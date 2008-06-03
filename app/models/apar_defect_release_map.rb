class AparDefectReleaseMap < ActiveRecord::Base
  belongs_to :apar
  belongs_to :defect
  belongs_to :release
end
