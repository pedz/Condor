# An image path is somewhat completely concocted but I keep them to
# help figure out which image paths I have not ransacked yet.
class CreateImagePaths < ActiveRecord::Migration
  def self.up
    create_table :image_paths do |t|
      t.string :path, :null => false
      t.integer :package_id, :null => false
      t.timestamps
    end
    execute "ALTER TABLE image_paths
             ADD CONSTRAINT unique_image_path_path
             UNIQUE (path)"
    execute "ALTER TABLE image_paths
             ADD CONSTRAINT fk_image_paths_package_id
             FOREIGN KEY (package_id) REFERENCES packages(id)
             ON DELETE CASCADE"
  end

  def self.down
    drop_table :image_paths
  end
end
