class CreateServicePackFilesetMaps < ActiveRecord::Migration
  def self.up
    create_table :service_pack_fileset_maps do |t|
      t.integer :service_pack_id
      t.integer :fileset_id

      t.timestamps
    end
  end

  def self.down
    drop_table :service_pack_fileset_maps
  end
end
