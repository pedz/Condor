#!/usr/bin/env ruby

# This script is used to import ptfapardef.constant files.

# load File.dirname(__FILE__) + '/../../script/runner'

# nby_ptf = Ptf.find(:first, :conditions => { :name => "Not Built Yet" })
# nby_release = Release.find(:first, :conditions => { :name => "Not Built Yet" })

begin
  Rails.logger.level = ActiveSupport::BufferedLogger::WARN
  
  File.open(ARGV[0]) do |file|
    Apar.transaction do 
      file.each_line do |line|
        d, m = file.lineno.divmod(1000)
        puts file.lineno if m == 0
        
        line.chomp!
        fields = line.split(/\|/)
        next if fields.length != 9
        
        ptf = Ptf.find_or_create_by_name fields[0]
        apar = Apar.find_or_create_by_name fields[1]
        defect = Defect.find_or_create_by_name fields[2]
        lpp_base = LppBase.find_or_create_by_name fields[3]
        lpp = lpp_base.lpps.find_or_create_by_name fields[4]
        
        family = Family.find_or_create_by_name fields[6]
        releases = fields[5].split(/ /).map do |release_name|
          version = Version.find_or_create_by_name release_name[-3,3]
          
          release_hash = {
            :name => release_name,
            :version_id => version.id
          }
          release = family.releases.find(:first, :conditions => release_hash)
          unless release
            release = family.releases.create(release_hash)
          end
          
          adv_hash = {
            :apar_id => apar.id,
            :defect_id => defect.id,
            :version_id => version.id
          }
          adv = AparDefectVersionMap.find(:first, :conditions => adv_hash)
          unless adv
            adv = AparDefectVersionMap.create(adv_hash)
          end
          
          apr_hash = {
            :apar_defect_version_map_id => adv.id,
            :ptf_id => ptf.id,
            :release_id => release.id
          }
          apr = AdvPtfReleaseMap.find(:first, :conditions => apr_hash)
          unless apr
            apr = AdvPtfReleaseMap.create(apr_hash)
          end
        end
        
        if apar.abstract.nil?
          apar.abstract = fields[7]
          apar.save!
        end
        
        fileset = lpp.filesets.find_or_create_by_vrmf fields[8]
        
        FilesetPtfMap.find_or_create_by_fileset_id_and_ptf_id(fileset.id, ptf.id)
      end
    end
  end
rescue => e
  puts e.message
  puts e.backtrace
  exit 1
end
