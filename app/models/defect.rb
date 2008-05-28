class Defect < ActiveRecord::Base
  has_many :apar_defect_maps
  has_many :defect_release_maps
end
