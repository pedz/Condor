class ImagePath < ActiveRecord::Base
  has_many :image_path_package_maps
  has_many :image_path_fileset_maps

  # Secondary Relationships
  has_many :packages, :through => :image_path_package_maps
  has_many :filesets, :through => :image_path_fileset_maps
end
