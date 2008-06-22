class AixFile < ActiveRecord::Base
  has_many :fileset_aix_file_maps

  # Secondary Relationships
  has_many :filesets, :through => :fileset_aix_file_maps
end
