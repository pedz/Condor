class FilesetAixFileMap < ActiveRecord::Base
  belongs_to :fileset
  belongs_to :aix_file
end
