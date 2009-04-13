class AparDefectVersionMap < ActiveRecord::Base
  belongs_to :apar
  belongs_to :defect
  belongs_to :version
  has_many   :adv_ptf_release_maps

  # Secondary Relations
  has_many   :ptfs,     :through => :adv_ptf_release_maps
  has_many   :releases, :through => :adv_ptf_release_maps
end
