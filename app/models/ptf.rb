class Ptf < ActiveRecord::Base
  has_many :adv_ptf_release_maps
  has_many :fileset_ptf_maps
  
  # Secondary relations
  has_many :apar_defect_version_maps, :through => :adv_ptf_release_maps
  has_many :ptfs,                     :through => :adv_ptf_release_maps
  has_many :releases,                 :through => :adv_ptf_release_maps
  has_many :filesets,                 :through => :fileset_ptf_maps

  def apars
    self.apar_defect_version_maps.map { |m| m.apar }
  end

  def defects
    self.apar_defect_version_maps.map { |m| m.defect }
  end

  def versions
    self.apar_defect_version_maps.map { |m| m.version }
  end

  def <=>(other)
    self.name <=> other.name
  end
end
