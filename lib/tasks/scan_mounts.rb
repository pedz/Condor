#!/usr/bin/env ruby

# This script is an all-in-one script that pulls in data from the
# install / update images on truth.

# Note that this script should be run as root with a command like:
# scripts/runner lib/tasks/scan_mounts

# It depends upon data being a symbolic link to the shared/data
# directory which should be set up via the capistrano deploy
# sequence.

# The first step is to mount each exported file system that we are
# interested in.  We mount them in data/mounts.  We mount them only as
# we need them.

MOUNT_LIST = [
              "truth.austin.ibm.com:/610images",
              "truth.austin.ibm.com:/530images",
              "truth.austin.ibm.com:/520images"
             ].freeze

ROOT = File.dirname(__FILE__) + "/../.."
DATA = ROOT + "/data"
MOUNT_POINT = DATA + "/mounts"

def main_loop
  MOUNT_LIST.each do |mount|
    host = mount.sub(/:.*$/, '')
    dir = mount.sub(/^.*:\//, '') # sans the leading slash
    p = Pathname.new("#{MOUNT_POINT}/#{dir}")
    unless p.mountpoint?        # may already be mounted
      p.mkpath                  # create the directory
      system("mount", mount, p.to_str) # mount the file system
    end
    p.find do |f|
    end
  end
end

main_loop
