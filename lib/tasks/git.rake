
# Returns the current hit head
def git_head
  Kernel.open("| git symbolic-ref HEAD").readlines[0].chomp.sub(/.*\//, '')
end

task :sync_production do
  sh "git push lab --all"
end

task :deploy => [ :sync_production ]do
  sh "cap --set-before env=production --set branch=#{git_head} deploy"
end

task :sync_staging do
  sh "git push p51 --all"
end

task :stage => [ :sync_staging ]do
  sh "cap --set-before env=staging --set branch=#{git_head} deploy"
end
