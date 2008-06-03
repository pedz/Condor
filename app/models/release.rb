class Release < ActiveRecord::Base
  belongs_to :family
  has_many :apar_defect_release_maps
end
