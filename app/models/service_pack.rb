class ServicePack < ActiveRecord::Base
  has_many :service_pack_fileset_map

  # Secondary Relationships
  has_many :filesets, :through => :service_pack_fileset_map
end
