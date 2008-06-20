class Apar < ActiveRecord::Base
  has_many :apar_defect_release_maps
  has_many :apar_ptf_maps
  
  # Secondary relations
  has_many :defects,  :through => :apar_defect_release_maps
  has_many :releases, :through => :apar_defect_release_maps
  has_many :ptfs,     :through => :apar_ptf_maps
end
