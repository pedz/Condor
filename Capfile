# -*- ruby -*-

load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

namespace :deploy do
  desc "Play task"
  task :play, :roles => :app do
    run "echo #{deploy_to}"
  end
  
  desc "Clear the production log via rake"
  task :log_clear, :roles => :app do
    run "cd #{current_path}/ && rake log:clear"
  end

  desc "The start task is used by :cold_deploy to start the application up"
  task :start, :roles => :app do
    # run "cd #{current_path}/ && mongrel_rails cluster::start"
  end

  desc "Restart the application"
  task :restart, :roles => :app do
    run "rm -f  #{current_path}/tmp/restart.txt; touch #{current_path}/tmp/restart.txt"
  end

  desc "No way to stop the application"
  task :stop, :roles => :app do
    # run "cd #{current_path}/ && mongrel_rails cluster::stop"
  end

  # desc "Hook to set up database.yml"
  # task :after_update_code, :roles => :app do
  #   run "cp #{db_path} #{release_path}/config/database.yml"
  #   run "ln -s #{shared_path}/data #{release_path}"
  # end
end

after "deploy:update_code" do
  run "cp #{db_path} #{release_path}/config/database.yml"
  run "cp #{ldap_path} #{release_path}/config/ldap.yml"
  run "ln -s #{shared_path}/data #{release_path}"
end
