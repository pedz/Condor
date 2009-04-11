
# Returns the current hit head
def git_head
  system("git symbolic-ref HEAD").sub(/.*\//, '')
end

task :sync_production do
  sh "git push lab --all"
end

task :deploy => [ :sync_production ]do
  sh "DEPLOY=PRODUCTION cap --set branch=#{git_head} deploy"
end

task :sync_staging do
  sh "git push p51 --all"
end

task :stage => [ :sync_staging ]do
  sh "DEPLOY=STAGING cap --set branch=#{git_head} deploy"
end
