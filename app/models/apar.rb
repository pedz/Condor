class Apar < ActiveRecord::Base
  has_many :apar_defect_version_maps
  # Secondary associations
  has_many :defects,              :through => :apar_defect_version_maps
  has_many :versions,             :through => :apar_defect_version_maps
  has_many :adv_ptf_release_maps, :through => :apar_defect_version_maps

  def ptfs
    self.adv_ptf_release_maps.map { |m| m.ptf }
  end

  def releases
    self.adv_ptf_release_maps.map { |m| m.release }
  end

  def <=>(other)
    self.name <=> other.name
  end
end
