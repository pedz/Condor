class Apar < ActiveRecord::Base
  has_many :apar_defect_version_maps
  
  # Secondary relations
  has_many :defects,  :through => :apar_defect_version_maps
  has_many :ptfs,     :through => :apar_defect_version_maps
  has_many :versions, :through => :apar_defect_version_maps

  def <=>(other)
    self.name <=> other.name
  end
end
