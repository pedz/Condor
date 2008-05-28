#!/usr/bin/env script/runner

File.open(ARGV[0]) do |file|
  file.each_line do |line|
    fields = line.split(/\|/)

    puts file.lineno if (d, m = file.lineno.divmod(1000)) && m == 0
    
    ptf = Ptf.find_or_create_by_name fields[0]
    apar = Apar.find_or_create_by_name fields[1]
    defect = Defect.find_or_create_by_name fields[2]
    base = Base.find_or_create_by_name fields[3]
    lpp = base.lpps.find_or_create_by_name fields[4]

    family = Family.find_or_create_by_name fields[6]
    releases = fields[5].split(/ /).map do |release|
      family.releases.find_or_create_by_name release
    end

    if apar.abstract.nil?
      apar.abstract = fields[7]
      apar.save
    end

    fileset = lpp.filesets.find_or_create_by_vrmf fields[8]

    AparDefectMap.find_or_create_by_apar_id_and_defect_id(apar.id, defect.id)
    AparPtfMap.find_or_create_by_apar_id_and_ptf_id(apar.id, ptf.id)
    releases.each do |release|
      DefectReleaseMap.find_or_create_by_defect_id_and_release_id(defect.id,
                                                                  release.id)
    end
    FilesetPtfMap.find_or_create_by_fileset_id_and_ptf_id(fileset.id, ptf.id)
  end
end
