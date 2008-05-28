class CreateFilesetPtfMaps < ActiveRecord::Migration
  def self.up
    create_table :fileset_ptf_maps do |t|
      t.integer :fileset_id
      t.integer :ptf_id

      t.timestamps
    end
  end

  def self.down
    drop_table :fileset_ptf_maps
  end
end
