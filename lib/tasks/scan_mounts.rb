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
# Next it reads the first four bytes to see if it is a  backup file (
# a possible install / update image.  If it is not a backup file, then
# a new image_paths is created with the package id set to the
# 'not-a-package' package and then returns.
# If all these tests pass, process_package is called.
BACKUP_MAGIC = "\x09\x00\x6b\xea".freeze
def process_file(image_path)
  relative_path = image_path.relative_path_from(MOUNT_POINT)
  return if ImagePath.find_by_path(relative_path)
  image_path.open do |file|
    magic = file.read(4)
    unless magic == BACKUP_MAGIC
      # Flat file that is not a backup image
      package = Package.find_or_create_by_name_and_sha1("not-a-package", "0")
      ImagePath.create(:path => relative_path, :package_id => package.id)
      return
    end
  end

  # calcualte the SHA1
  hexdigest = Digest::SHA1.file(image_path)

  base = image_path.basename
  found_one = false
  Package.find_all_by_sha1(hexdigest).each do |package|
    # If we find at least one package, then we will not process the
    # file again.
    found_one = true

    # If it has the same basename, then we just create a new image
    # image_path to point to it and we're done
    if package.name == base
      ImagePath.create(:path => relative_path, :package_id => package.id)
      return
    end
  end

  # If we did not find any packages with the same SHA1, we call
  # process package to dig into the package and get all of the goodies
  # out of it.
  unless found_one
    unless process_package(image_path)
      package = Package.find_or_create_by_name_and_sha1("error-package", "0")
      ImagePath.create(:path => relative_path, :package_id => package.id)
      return
    end
  end
  

  # We create a new package with the new basename and create an image
  # image_path to point to it.
  package = Package.new(:name => base, :sha1 => hexdigest)
  ImagePath.create(:path => relative_path, :package_id => package.id)
end

# At this point, we know that image_path is a backup file and we will
# restore its contents in a temp directory and then try to understand
# it.  This should return true if no errors happened and false if we
# hit an error that is so bad we need to re-process the file somehow.
def process_package(image_path)
  begin
    restore_package(image_path)
    # The old "populate" script would change the permissions on all the
    # directories in the exploided package be 777.  It would then add
    # write permissions to everything.  I can't recall why that was done
    # but as I recall, there was a reason for it.  Perhaps it was so we
    # could delete it when we were done.  I'm not going to do that yet.
    
    # We now need to understand the lpp_name file if one exists.  If one
    # does not, then we just exit.
    lpp_name = TEMP_DIR + "lpp_name"
    unless lpp_name.file?
      return
    end
    packages = nil
    lpp_name.open do |file|
      packages = Toc::Parser.parse(file)
    end
    # We should have only one package in the list of packages since
    # this is an lpp_name and not a .toc.
    packages.each do |package|
      package.filesets.each do |fileset|
        puts "#{package.name} #{fileset.name} #{fileset.vrmf}"
      end
    end
    exit(0)
  rescue => e
    puts e.message
    puts e.backtrace
    exit(1)
  ensure
    # remove_temp_dir
  end
end

def remove_temp_dir
  TEMP_DIR.rmtree if TEMP_DIR.directory?
end

def restore_package(image_path)
  remove_temp_dir
  TEMP_DIR.mkpath
  pid = Kernel.fork
  
  # Child
  if pid.nil?
    $stdin.reopen(image_path)
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


begin
  main_loop
rescue => e
  puts e.message
  puts e.backtrace
end
