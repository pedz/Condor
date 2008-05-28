class Fileset < ActiveRecord::Base
  belongs_to :lpp
  has_many :fileset_ptf_maps
  has_many :service_pack_fileset_map
end
