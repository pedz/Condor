class Ptf < ActiveRecord::Base
  has_many apar_ptf_maps
  has_many fileset_ptf_maps
end
