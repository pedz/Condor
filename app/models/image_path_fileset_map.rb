class ImagePathFilesetMap < ActiveRecord::Base
  belongs_to :image_path
  belongs_to :fileset
end
