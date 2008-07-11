class AparDefectPtfReleaseMaps < ActiveRecord::Base
  belongs_to :apar
  belongs_to :defect
  belongs_to :ptf
  belongs_to :release
end
