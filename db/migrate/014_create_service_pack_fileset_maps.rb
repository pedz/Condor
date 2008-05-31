class CreateServicePackFilesetMaps < ActiveRecord::Migration
  def self.up
    create_table :service_pack_fileset_maps do |t|
      t.integer :service_pack_id, :null => false
      t.integer :fileset_id, :null => false
      t.timestamps
    end
    execute "ALTER TABLE service_pack_fileset_maps
             ADD CONSTRAINT unique_service_pack_fileset_map_service_pack_fileset
             UNIQUE (service_pack_id, fileset_id)"
    execute "CREATE INDEX service_pack_fileset_maps_fileset_idx
             ON service_pack_fileset_maps(fileset_id);"
  end

  def self.down
    execute "DROP INDEX service_pack_fileset_maps_fileset_idx"
    drop_table :service_pack_fileset_maps
  end
end
