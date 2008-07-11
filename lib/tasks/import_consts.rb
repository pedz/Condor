#!/usr/bin/env script/runner

File.open(ARGV[0]) do |file|
  Apar.transaction do 
    file.each_line do |line|
      puts file.lineno if (d, m = file.lineno.divmod(1000)) && m == 0

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
        AparDefectPtfReleaseMap.find_or_create_by_apar_id_and_defect_id_and_ptf_id_and_release_id(apar.id,
                                                                                                  defect.id,
                                                                                                  ptf.id,
                                                                                                  release.id)
      end
      FilesetPtfMap.find_or_create_by_fileset_id_and_ptf_id(fileset.id, ptf.id)
    end
  end
end
