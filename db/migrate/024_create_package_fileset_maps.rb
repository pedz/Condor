# A package ships many filesets.  But the next package may ship a
# subset of the previous filesets un changed.  Thus there must be a
# many to many mapping from packages to filesets.  This map provides
# that mappig.
class CreatePackageFilesetMaps < ActiveRecord::Migration
  def self.up
    create_table :package_fileset_maps do |t|
      t.integer :package_id, :null => false
      t.integer :fileset_id, :null => false
      t.timestamps
    end
    execute "ALTER TABLE package_fileset_maps
             ADD CONSTRAINT unique_package_fileset_map_package_fileset
             UNIQUE (package_id, fileset_id)"
    execute "ALTER TABLE package_fileset_maps
             ADD CONSTRAINT fk_package_fileset_maps_package_id
             FOREIGN KEY (package_id) REFERENCES packages(id)
             ON DELETE CASCADE DEFERRABLE"
    execute "ALTER TABLE package_fileset_maps
             ADD CONSTRAINT fk_package_fileset_maps_fileset_id
             FOREIGN KEY (fileset_id) REFERENCES filesets(id)
             ON DELETE CASCADE DEFERRABLE"
  end

  def self.down
    drop_table :package_fileset_maps
  end
end
