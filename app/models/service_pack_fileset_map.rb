class ServicePackFilesetMap < ActiveRecord::Base
  belongs_to :service_pack
  belongs_to :fileset
end
