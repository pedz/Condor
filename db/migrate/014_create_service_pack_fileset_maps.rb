# It may be that a fileset ships in only one service pack but I rather
# doubt it.  And clearly a service pack ships many filesets.  So the
# mapping must be many to many.  This map provides that.
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
    execute "ALTER TABLE service_pack_fileset_maps
             ADD CONSTRAINT fk_service_pack_fileset_maps_service_pack_id
             FOREIGN KEY (service_pack_id) REFERENCES service_packs(id)
             ON DELETE CASCADE DEFERRABLE"
    execute "ALTER TABLE service_pack_fileset_maps
             ADD CONSTRAINT fk_service_pack_fileset_maps_fileset_id
             FOREIGN KEY (fileset_id) REFERENCES filesets(id)
             ON DELETE CASCADE DEFERRABLE"
  end

  def self.down
    execute "DROP INDEX service_pack_fileset_maps_fileset_idx"
    drop_table :service_pack_fileset_maps
  end
end
