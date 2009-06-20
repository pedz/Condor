# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

ENV["FIXTURES"] ||=
  "aix_files," +
  "apars," +
  "defects," +
  "families," +
  "ptfs," +
  "lpp_bases," +
  "lpps," +
  "filesets," +
  "versions," +
  "releases," +
  "packages," +
  "image_paths," +
  "fileset_aix_file_maps," +
  "fileset_ptf_maps," +
  "package_fileset_maps," +
  "service_packs," +
  "service_pack_fileset_maps," +
  "apar_defect_version_maps," +
  "adv_ptf_release_maps"

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

desc "Create a TAGS file"
task :create_tags do
  system("rm -f TAGS; " +
         "find . \\( -name '*.rb' -o -name '*.js' \\) -print | " +
         "egrep -v '/\.git/' | xargs /usr/local/bin/ctags -ea")
end
