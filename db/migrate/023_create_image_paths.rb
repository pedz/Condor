# An image path is somewhat completely concocted but I keep them to
# help figure out which image paths I have not ransacked yet.
class CreateImagePaths < ActiveRecord::Migration
  def self.up
    create_table :image_paths do |t|
      t.string :path, :null => false, :unique => true
      t.fk :package_id
      t.timestamps
    end
  end

  def self.down
    drop_table :image_paths
  end
end
