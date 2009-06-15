
namespace :db do
  desc "Restore condor's database from a specified file"
  task :restore, [:filename] do |t, args|
    raise "task restore: filename expected" unless !args.filename.blank?
    sh "pg_restore -U condor --no-owner --dbname=condor_production /usr/local/condor.db"
  end

  desc "Dump condor's database to a specified file"
  task :dump, [:filename] do |t, args|
    raise "task dump: filename expected" unless !args.filename.blank?
    sh "pg_dump -U pedzan --file=#{args.filename} --format=custom condor_development"
  end
end
