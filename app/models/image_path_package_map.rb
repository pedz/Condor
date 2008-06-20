class ImagePathPackageMap < ActiveRecord::Base
  belongs_to :image_path
  belongs_to :package
end
