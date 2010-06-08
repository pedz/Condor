
namespace :db do
  desc "Restore condor's database from a specified file"
  task :restore, [:filename] => :load_config do |t, args|
    raise "task restore: filename expected" unless !args.filename.blank?
    config = ActiveRecord::Base.configurations[RAILS_ENV]
    puts "This will produce three warnings about PUBLIC schema"
    sh "pg_restore -U #{config["username"]} --clean --no-owner --dbname=#{config["database"]} #{args.filename}"
  end

  desc "Dump condor's database to a specified file but excludes the user and cmvc tables"
  task :dump, [:filename] => :load_config do |t, args|
    raise "task dump: filename expected" unless !args.filename.blank?
    config = ActiveRecord::Base.configurations[RAILS_ENV]
    sh "pg_dump -U #{config["username"]} --file=#{args.filename} --exclude-table=users --exclude-table=cmvcs --format=custom #{config["database"]}"
  end
end
