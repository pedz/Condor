class AdvPtfReleaseMap < ActiveRecord::Base
  belongs_to :apar_defect_version_map
  belongs_to :ptf
  belongs_to :release
end
