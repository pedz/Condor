class CreateImagePathFilesetMaps < ActiveRecord::Migration
  def self.up
    create_table :image_path_fileset_maps do |t|
      t.integer :image_path_id
      t.integer :fileset_id
      t.timestamps
    end
    execute "ALTER TABLE image_path_fileset_maps
             ADD CONSTRAINT unique_image_path_fileset_map_image_path_fileset
             UNIQUE (image_path_id, fileset_id)"
    execute "ALTER TABLE image_path_fileset_maps
             ADD CONSTRAINT fk_image_path_fileset_maps_image_path_id
             FOREIGN KEY (image_path_id) REFERENCES image_paths(id)
             ON DELETE CASCADE"
    execute "ALTER TABLE image_path_fileset_maps
             ADD CONSTRAINT fk_image_path_fileset_maps_fileset_id
             FOREIGN KEY (fileset_id) REFERENCES filesets(id)
             ON DELETE CASCADE"
  end

  def self.down
    drop_table :image_path_fileset_maps
  end
end
