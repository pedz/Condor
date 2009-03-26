class CreateNotBuiltYetObjects < ActiveRecord::Migration
  def self.up
    ptf = Ptf.find_or_create_by_name("Not Built Yet")
    family = Family.find_or_create_by_name("Not Built Yet")
    lpp_base = LppBase.find_or_create_by_name("Not Built Yet")
    lpp = Lpp.find_or_create_by_name_and_lpp_base_id("Not Built Yet", lpp_base.id)
    release = Release.find_or_create_by_name_and_family_id("Not Built Yet", family.id)
    fileset = Fileset.find_or_create_by_vrmf_and_lpp_id("0.0.0.0", lpp.id)
    fpm = FilesetPtfMap.find_or_create_by_fileset_id_and_ptf_id(fileset.id, ptf.id)
  end

  def self.down
  end
end
