class AparDefectVersionMap < ActiveRecord::Base
  belongs_to :apar
  belongs_to :defect
  belongs_to :version
end
