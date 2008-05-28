class AparDefectMap < ActiveRecord::Base
  belongs_to :apar
  belongs_to :defect
end
