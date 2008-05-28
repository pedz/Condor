class DefectReleaseMap < ActiveRecord::Base
  belongs_to :defect
  belongs_to :release
end
