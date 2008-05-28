class CreateServicePackFilesetMaps < ActiveRecord::Migration
  def self.up
    create_table :service_pack_fileset_maps do |t|
      t.integer :service_pack_id
      t.integer :fileset_id
      t.timestamps
    end
    execute "ALTER TABLE service_pack_fileset_maps ADD CONSTRAINT
             unique_service_pack_fileset_map_service_pack_fileset
             UNIQUE (service_pack_id, fileset_id)"
  end

  def self.down
    drop_table :service_pack_fileset_maps
  end
end
