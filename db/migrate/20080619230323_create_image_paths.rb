class CreateImagePaths < ActiveRecord::Migration
  def self.up
    create_table :image_paths do |t|
      t.string :path
      t.timestamps
    end
    execute "ALTER TABLE image_paths
             ADD CONSTRAINT unique_image_path_path
             UNIQUE (path)"
  end

  def self.down
    drop_table :image_paths
  end
end
