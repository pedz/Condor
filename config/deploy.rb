# -*- coding: utf-8 -*-

unless respond_to?(:env)
  STDERR.puts "Please use --set-before env=<env>"
  exit 1
end

if env == 'production'
  set :domain,      "condor@tcp237.austin.ibm.com"
elsif env == 'staging'
  set :domain,      "condor@p51.austin.ibm.com"
else
  STDERR.puts "env must be 'production' or 'staging'"
  exit 1
end

set :application,           "condor"
set :repository,            "#{domain}:repositories/condor.git"
set :scm,                   :git
set :deploy_via,            :copy
set :branch,                "master"
set :copy_remote_tar,       "/usr/local/bin/tar"
set :git_enable_submodules, true

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:

# deploy_base is my own variable that is the base of where all the
# rails applications live.
set :deploy_base, "/usr/local/www"

# The real database.yml is kept out of the tree in this path
set :db_path, "#{deploy_base}/database-files/#{application}-database.yml"

# The deploy_to is a variable that Capistrano needs
set :deploy_to, "#{deploy_base}/#{application}"
set :use_sudo, false

role :app, domain
role :web, domain
role :db,  domain, :primary => true
