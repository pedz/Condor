#!/usr/bin/env ruby

# I gave up trying to use runner magically.  To run these scripts just
# type out the whole command like:
# script/runner lib/tasks/import_images.rb file1 file2 ...

# This script expects standard input to be a list of lines of two
# forms.  One form has four fields separated by spaces.  These fields
# are the image path, package name, fileset name, vrmf.  These come in
# a sequence with the same image path.  The other type of line has
# three fields which are the image path, fileset name, aix file path.

# Currently, the db is a bit stupid.  I have a many to many mapping
# from image_paths to/from packages, packages to/from filesets, and
# image_paths to/from filesets. A bit overkill probably.

begin
  debug = false
  image_path = nil
  fileset = nil
  aix_file = nil
  package = nil
  lpp_base = nil
  lpp = nil
  last_bad_image_path = nil
  last_bad_fileset = nil
  
  $stdin.each_line do |line|
    # puts $stdin.lineno
    line.chomp!
    fields = line.split           # split on spaces
    case fields.length
    when 3                        # image path, fileset name, aix file
      # Find the new image_path
      unless image_path && image_path.path == fields[0]
        if image_path
          image_path.save!
          image_path = nil
        end
        if package
          package.save!
          package = nil
        end
        if fileset
          fileset.save!
          fileset = nil
        end
        begin
          next if last_bad_image_path == fields[0]
          last_bad_image_path = nil
          last_bad_fileset = nil
          image_path = ImagePath.find_by_path fields[0] # should already exist
        rescue
          last_bad_image_path = fields[0]
          puts "Image path #{fields[0]} requested at line #{$stdin.lineno} not found."
          next
        end
      end
      
      # We actually have the lpp name.  So...
      unless fileset && fileset.lpp.name == fields[1]
        if fileset
          fileset.save!
        end
        
        # Scan filesets connected with this image_path to find the one
        # whose lpp name matches the fileset name.
        next if last_bad_fileset == fields[1]
        last_bad_fileset = nil
        filesets = image_path.filesets.find_all { |fileset|
          fileset.lpp.name == fields[1]
        }

        if filesets.length > 1
          puts "More than one filesets #{filesets.inspect} found for #{image_path.path}"
          last_bad_fileset = fields[1]
          next
        end

        if filesets.empty?
          puts "Fileset #{fields[1]} not found for #{image_path.path} requested at line #{$stdin.lineno}"
          last_bad_fileset = fields[1]
          next
        end
        
        fileset = filesets[0]
      end
      
      unless fileset.aix_files.find_by_path fields[2]
        aix_file = AixFile.find_or_create_by_path fields[2]
        if debug
          puts "Adding #{aix_file.path} to #{fileset.lpp.name}:#{fileset.vrmf}"
        end
        fileset.aix_files << aix_file 
      end
      
    when 4
      unless image_path && image_path.path == fields[0]
        if image_path
          image_path.save!
          image_path = nil
        end
        if package
          package.save!
          package = nil
        end
        if fileset
          fileset.save!
          fileset = nil
        end
        # puts "Image path #{fields[0]}"
        image_path = ImagePath.find_or_create_by_path fields[0]
      end
      
      unless package && package.name == fields[1]
        if package
          package.save!
          package = nil
        end
        package = Package.find_or_create_by_name fields[1]
      end
      
      lpp_base_name = fields[2].sub(/\..*/, '')
      unless lpp_base && lpp_base.name == lpp_base_name
        if lpp_base
          lpp_base.save!
          lpp_base = nil
        end
        if lpp
          lpp.save!
          lpp = nil
        end
        if fileset
          fileset.save!
          fileset = nil
        end
        lpp_base = LppBase.find_or_create_by_name fields[2].sub(/\..*/, '')
      end
      
      unless lpp && lpp.name == fields[2]
        if lpp
          lpp.save!
          lpp = nil
        end
        if fileset
          fileset.save!
          fileset = nil
        end
        lpp = lpp_base.lpps.find_or_create_by_name fields[2]
      end
      
      unless fileset && fileset.vrmf == fields[3]
        if fileset
          fileset.save!
          fileset = nil
        end
        fileset = lpp.filesets.find_or_create_by_vrmf fields[3]
      end
      
      # Create image_path <=> package mapping
      unless image_path.packages.find_by_name(package.name)
        if debug
          puts "Adding package #{package.name} to image_path #{image_path.path}"
        end
        image_path.packages << package
      end
      
      # Create fileset <=> package mapping
      unless fileset.packages.find_by_name(package.name)
        if debug
          puts("Adding package #{package.name} " +
               "to fileset #{fileset.lpp.name}:#{fileset.vrmf}")
        end
        fileset.packages << package
      end
      
      # Create fileset <=> image_path mapping
      unless fileset.image_paths.find_by_path(image_path.path)
        if debug
          puts("Adding image_path #{image_path.path} " +
               "to fileset #{fileset.lpp.name}:#{fileset.vrmf}")
        end
        fileset.image_paths << image_path
      end
      image_path.save!
      fileset.save!
    end
  end
  
  if image_path
    image_path.save!
  end
  
  if fileset
    fileset.save!
  end
  
  if aix_file
    aix_file.save!
  end
  
  if package
    package.save!
  end
  
  if lpp_base
    lpp_base.save!
  end
  
  if lpp
    lpp.save!
  end
  
rescue => e
  puts e.inspect
  puts e.backtrace
end
