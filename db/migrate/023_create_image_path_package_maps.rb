class CreateImagePathPackageMaps < ActiveRecord::Migration
  def self.up
    create_table :image_path_package_maps do |t|
      t.integer :image_path_id
      t.integer :package_id
      t.timestamps
    end
    execute "ALTER TABLE image_path_package_maps
             ADD CONSTRAINT unique_image_path_package_maps_image_path_package
             UNIQUE (image_path_id, package_id)"
    execute "ALTER TABLE image_path_package_maps
             ADD CONSTRAINT fk_image_path_package_maps_image_path_id
             FOREIGN KEY (image_path_id) REFERENCES image_paths(id)
             ON DELETE CASCADE"
    execute "ALTER TABLE image_path_package_maps
             ADD CONSTRAINT fk_image_path_package_maps_package_id
             FOREIGN KEY (package_id) REFERENCES packages(id)
             ON DELETE CASCADE"
  end

  def self.down
    drop_table :image_path_package_maps
  end
end
