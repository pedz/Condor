#!/usr/bin/env ruby

# This script is an all-in-one script that pulls in data from the
# install / update images on truth.

# Note that this script should be run as root with a command like:
# scripts/runner lib/tasks/scan_mounts

# It depends upon data being a symbolic link to the shared/data
# directory which should be set up via the capistrano deploy
# sequence.

# The first step is to mount each exported file system that we are
# interested in.  We mount them in data/mounts.  We mount them only as
# we need them.

require File.dirname(__FILE__) + "/toc-parser"

MOUNT_LIST = [
              "truth.austin.ibm.com:/610images",
              "truth.austin.ibm.com:/530images",
              "truth.austin.ibm.com:/520images"
             ].freeze

ROOT = Pathname.new(File.dirname(__FILE__) + "/../..").realpath
DATA = (ROOT + "data").realpath
MOUNT_POINT = DATA + "mounts"
TEMP_DIR = DATA + "temp"

# main_loop of the scan_mounts script runs thru the MOUNT_LIST.  For
# each item in the list, it creates a mount point if one does not
# already exists and mounts the file system if it is not already
# mounted.  Then it does a find on the new mounted file system.  For
# each flat file, process_file is called.
def main_loop
  MOUNT_LIST.each do |mount|
    host = mount.sub(/:.*$/, '')
    dir = mount.sub(/^.*:\//, '') # sans the leading slash
    mount_path = MOUNT_POINT + dir
    unless mount_path.mountpoint?        # may already be mounted
      mount_path.mkpath                  # create the directory
      system("mount", mount, mount_path) # mount the file system
    end
    mount_path.cleanpath.find do |image_path|
      next unless image_path.file?    # skip all but flat files
      process_file(image_path)
    end
  end
end

# Process file first sees if this image_path is already in image_paths.  If
# it is, it assumes that things have not changed and it is skipped.
# It then creates an ImageFile and passes the processing off to it.
def process_file(image_path)
  relative_path = image_path.relative_path_from(MOUNT_POINT)
  return if ImagePath.find_by_path(relative_path)
  image_file = ImageFile.new(ImagePath.new(:path => relative_path), image_path)
  image_file.process
end

# ImageFile is a class to contain the work of processing an image
# file.
class ImageFile
  def initialize(image, full_path)
    @image, @full_path = image, full_path
  end
  
  BACKUP_MAGIC = "\x09\x00\x6b\xea".freeze
  
  # reads the first four bytes to see if it is a backup file ( a
  # possible install / update image.  If it is not a backup file, then
  # a new image_paths is created with the package id set to the
  # 'not-a-backup' package and then returns.  If all these tests pass,
  # process_package is called.
  def process
    @full_path.open do |file|
      magic = file.read(4)
      unless magic == BACKUP_MAGIC
        # Flat file that is not a backup image
        @image.package = not_a_backup
        @image.save
        return
      end
    end
    
    # calcualte the SHA1
    @sha1 = Digest::SHA1.file(@full_path).hexdigest
    
    # We assume that two files with the same SHA1 are the same file
    # in a different location.
    if package = Package.find_by_sha1(@sha1)
      @image.package = package
      @image.save
      return
    end

    process_package
  end
  
  private
  
  # At this point, we know that @full_path is a backup file and we will
  # restore its contents in a temp directory and then try to understand
  # it.  This should return true if no errors happened and false if we
  # hit an error that is so bad we need to re-process the file somehow.
  INVENTORY_REGEXP = /^(.*)\.inventory$/.freeze
  COLON_REGEXP = /^(.*):.*$/.freeze
  
  def process_package
    begin
      restore_package

      # The old "populate" script would change the permissions on all the
      # directories in the exploided package be 777.  It would then add
      # write permissions to everything.  I can't recall why that was done
      # but as I recall, there was a reason for it.  Perhaps it was so we
      # could delete it when we were done.  I'm not going to do that yet.
      
      # We now need to understand the lpp_name file if one exists.  If one
      # does not, then we just exit.
      lpp_name = TEMP_DIR + "lpp_name"
      return unless lpp_name.file?

      lpp_name.open do |file|
        # We assume each image path has only one package.  This may
        # not be dictated anywhere so we are going to check and make
        # sure it is true.
        first_time = true
        Toc::Parser.parse(file).each do |parsed_package|
          unless first_time
            STDERR.puts "#{@full_path} has more than one package in its lpp_name"
            exit(1)
          end
          @package = new_package(parsed_package.name)
          @image.package = @package
          fileset_hash = { }
          parsed_package.filesets.each do |parsed_fileset|
            fs = fileset(parsed_fileset)
            if fileset_hash.has_key?(fs.lpp.name)
              STDERR.puts "Image at #{@full_path} has two filesets with the " +
                "same lpp name of #{fs.lpp.ame}"
              exit(1)
            end
            fileset_hash[fs.lpp.name] = fs
            @package.filesets << fs
          end

          # We find all of the liblpp.a files, create a directory
          # called liblpp in the same directory and then expand the
          # libllpp.a file into it.  We pull out the .inventory files
          TEMP_DIR.find do |path|
            next unless path.basename.to_s == "liblpp.a"
            expand_liblpp(path) do |child|
              next unless (match1 = INVENTORY_REGEXP.match(child.basename.to_s))
              if (fs = fileset_hash[match1[1]]).nil?
                STDERR.puts "Image at #{@full_path} has inventory file " +
                  "for '#{match[1]}' but was not entered in the lpp_name." +
                  " - skipping..."
                next
              end

              # child is now an inventory file that we dug out of one
              # of the liblpp.a files.  We find the lines with a colon
              # which are the full path names of the installed files.
              child.readlines.each do |line|
                next unless (match2 = COLON_REGEXP.match(line))
                fs.aix_files << aix_file(match2[1])
              end
            end
          end
        end
      end
      @image.save
    rescue => e
      STDERR.puts e.message
      STDERR.puts e.backtrace
      exit(1)
    ensure
      # remove_temp_dir
    end
  end
  
  def aix_file(installed_path)
    local_path = TEMP_DIR + installed_path[1..-1]
    if local_path.file?
      sha1 = Digest::SHA1.file(local_path).hexdigest
    else
      sha1 = "0"
    end
    AixFile.find_or_create_by_path_and_sha1(installed_path, sha1)
  end
                
  def remove_temp_dir
    TEMP_DIR.rmtree if TEMP_DIR.directory?
  end
  
  def expand_liblpp(path)
    dir = path.dirname + "liblpp"
    dir.mkdir
    pid = Kernel.fork
    if pid.nil?
      Dir.chdir(dir)
      Kernel.exec("/usr/bin/ar", "x", "../liblpp.a")
    end

    Process.wait(pid)
    status = $?
    if status != 0
      STDERR.puts "ar x of #{path} failed"
      exit(1)
    end

    dir.children.each do |c|
      yield c
    end
  end

  def restore_package
    remove_temp_dir
    TEMP_DIR.mkpath
    pid = Kernel.fork
    
    # Child
    if pid.nil?
      $stdin.reopen(@full_path)
      $stdout.close
      Dir.chdir(TEMP_DIR.to_s)
      Kernel.exec("/usr/sbin/restore", "-xqf", "-")
    end
    
    # Parent
    Process.wait(pid)
    status = $?
    if status != 0
      STDERR.puts "restore exited with status of #{status}"
      exit(1)
    end
  end
  
  # We know that sha1 is not in the database so we know that the tuple
  # [name, sha1] will not be in the database as well.
  def new_package(package_name)
    Package.new(:name => package_name, :sha1 => @sha1)
  end
  
  def error_package
    Package.find_or_create_by_name_and_sha1("error-package", "0")
  end
  
  def not_a_backup
    Package.find_or_create_by_name_and_sha1("not-a-backup", "0")
  end

  def lpp_base(lpp_name)
    LppBase.find_or_create_by_name lpp_name.sub(/\..*/, '')
  end

  def lpp(lpp_name)
    lpp_base(lpp_name).lpps.find_or_create_by_name(lpp_name)
  end

  def fileset(parsed_fileset)
    lpp(parsed_fileset.name).filesets.find_or_create_by_vrmf(parsed_fileset.vrmf)
  end

end


begin
  main_loop
rescue => e
  STDERR.puts e.message
  STDERR.puts e.backtrace
  exit(1)
end
