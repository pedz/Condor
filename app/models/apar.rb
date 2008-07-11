class Apar < ActiveRecord::Base
  has_many :apar_defect_ptf_release_maps
  
  # Secondary relations
  has_many :defects,  :through => :apar_defect_ptf_release_maps
  has_many :ptfs,     :through => :apar_defect_ptf_release_maps
  has_many :releases, :through => :apar_defect_ptf_release_maps
end
