class FilesetPtfMap < ActiveRecord::Base
  belongs_to :fileset
  belongs_to :ptf
end
