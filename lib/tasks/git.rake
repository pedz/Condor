
# Returns the current git head
def git_head
  Kernel.open("| git symbolic-ref HEAD").readlines[0].chomp.sub(/.*\//, '')
end

desc "Pushs git repository to production server"
task :sync_production do
  sh "git push lab --all"
end

desc "Deploy to production server"
task :deploy => [ :sync_production ]do
  sh "cap --set-before env=production --set branch=#{git_head} deploy"
end

desc "Pushs git repository to staging server"
task :sync_staging do
  sh "git push p51 --all"
end

desc "Deploy to staging server"
task :stage => [ :sync_staging ]do
  sh "cap --set-before env=staging --set branch=#{git_head} deploy"
end
