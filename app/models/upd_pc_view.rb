class UpdPcView < ActiveRecord::Base
  belongs_to :ptf
  belongs_to :fileset
  belongs_to :defect
  belongs_to :version
end
