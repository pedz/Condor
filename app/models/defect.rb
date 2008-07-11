class Defect < ActiveRecord::Base
  has_many :apar_defect_ptf_release_maps
  
  # Secondary relations
  has_many :apars,  :through => :apar_defect_ptf_release_maps
  has_many :ptfs,     :through => :apar_defect_ptf_release_maps
  has_many :releases, :through => :apar_defect_ptf_release_maps
end
