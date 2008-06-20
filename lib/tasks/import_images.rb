#!/usr/bin/env script/runner

# This script expects standard input to be a list of lines of two
# forms.  One form has four fields separated by spaces.  These fields
# are the image path, package name, fileset name, vrmf.  These come in
# a sequence with the same image path.  The other type of line has
# three fields which are the image path, fileset name, aix file path.

# Currently, the db is a bit stupid.  I have a many to many mapping
# from image_paths to/from packages, packages to/from filesets, and
# image_paths to/from filesets. A bit overkill probably.

$stdin.each_line do |line|
  puts $stdin.lineno if (d, m = $stdin.lineno.divmod(1000)) && m == 0
  line.chomp!
  fields = line.split           # split on spaces
  case fields.length
  when 3                        # image path, fileset name, aix file
    ip = ImagePath.find_by_path(fields[0]) # should already exist
    fs = ip.filesets.find_by_name(fields[1]) # should exist as well
    ap = fs.aix_files.find_or_create_by_path(fields[2])
  when 4
    
  end
end
