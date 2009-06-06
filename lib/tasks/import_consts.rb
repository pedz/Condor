#!/usr/bin/env ruby

load File.dirname(__FILE__) + '/../../script/runner'

nby_ptf = Ptf.find(:first, :conditions => { :name => "Not Built Yet" })
nby_release = Release.find(:first, :conditions => { :name => "Not Built Yet" })

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
      releases = fields[5].split(/ /).map do |release|
        family.releases.find_or_create_by_name release
      end
      
      if apar.abstract.nil?
        apar.abstract = fields[7]
        apar.save!
      end
      
      fileset = lpp.filesets.find_or_create_by_vrmf fields[8]
      
      releases.each do |release|
        hash = {
          :defect_id => defect.id,
          :apar_id => apar.id,
          :ptf_id => nby_ptf.id,
          :release_id => nby_release.id
        }
        if (a = AparDefectPtfReleaseMap.find(:first, :conditions => hash))
          a.update_attributes(:ptf_id => ptf.id, :release_id => release.id)
          next
        end

        hash.ptf_id = ptf.id
        if (a = AparDefectPtfReleaseMap.find(:first, :conditions => hash))
          a.update_attributes(:release_id => release.id)
          next
        end
        
        hash.release_id = release.id
        if (a = AparDefectPtfReleaseMap.find(:first, :conditions => hash))
          next
        end

        AparDefectPtfReleaseMap.create(:conditions => hash)
      end
      FilesetPtfMap.find_or_create_by_fileset_id_and_ptf_id(fileset.id, ptf.id)
    end
  end
end
