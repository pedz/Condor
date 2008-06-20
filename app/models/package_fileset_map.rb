class PackageFilesetMap < ActiveRecord::Base
  belongs_to :package
  belongs_to :fileset
end
