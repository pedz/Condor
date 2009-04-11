# -*- ruby -*-

# Returns the current hit head
def git_head
  system("git symbolic-ref HEAD").sub(/.*\//, '')
end
