class Apar < ActiveRecord::Base
  has_many :apar_defect_maps
  has_many :apar_ptf_maps
end
