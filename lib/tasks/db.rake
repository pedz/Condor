
namespace :db do
  desc "Restore condor's database from a specified file"
  task :restore, [:filename] => [ "db:drop", "db:create" ] do |t, args|
    raise "task restore: filename expected" unless !args.filename.blank?
    config = ActiveRecord::Base.configurations[RAILS_ENV]
    sh "pg_restore -U #{config["username"]} --no-owner --dbname=#{config["database"]} #{args.filename}"
  end

  desc "Dump condor's database to a specified file"
  task :dump, [:filename] => :load_config do |t, args|
    raise "task dump: filename expected" unless !args.filename.blank?
    config = ActiveRecord::Base.configurations[RAILS_ENV]
    sh "pg_dump -U #{config["username"]} --file=#{args.filename} --format=custom #{config["database"]}"
  end
end
