class Package < ActiveRecord::Base
  has_many :image_path_package_maps
  has_many :package_fileset_maps

  def <=>(other)
    this.name <=> other.name
  end
end
