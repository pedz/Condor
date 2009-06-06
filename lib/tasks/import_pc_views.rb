#!/usr/bin/env ruby

# Sample input:
#
# 315731|rayc|aix|42G|APPROVED|NO_REQS_NEEDED|NO_NEEDED|
# 302632|frankzhu|aix|42G|APPROVED|NO_REQS_NEEDED|NEEDS_ONE|
# 220324|frankzhu|aix|42G|OPEN|UNKNOWN|NOT_SPECIFIED|


require File.dirname(__FILE__) + '/../../script/runner'

GOOD_FAMILY = Regexp.new("aix")
GOOD_VERSION = Regexp.new("^(5[234].|6..)$")

begin
  File.open(ARGV[0]) do |file|
    Apar.transaction do
      file.each_line do |line|
        line.chomp!
        defect, owner, family, version, state, apar_state, apar, ptfs = line.split('|')
        next unless GOOD_FAMILY.match(family)
        next unless GOOD_VERSION.match(version)
        defect = Defect.find_or_create_by_name defect
        apar = Apar.find_or_create_by_name apar
        version = Version.find_or_create_by_name version
        
        adv_hash = {
          :apar_id => apar.id,
          :defect_id => defect.id,
          :version_id => version.id
        }
        adv = AparDefectVersionMap.find(:first, :conditions => adv_hash)
        unless adv
          adv = AparDefectVersionMap.create(adv_hash)
        end
      end
    end
  end
rescue => e
  puts e.message
  puts e.backtrace
  exit 1
end
