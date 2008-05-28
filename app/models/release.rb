class Release < ActiveRecord::Base
  belongs_to :family
  has_many :defect_release_maps
end
