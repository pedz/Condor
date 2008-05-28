class CreateFilesetPtfMaps < ActiveRecord::Migration
  def self.up
    create_table :fileset_ptf_maps do |t|
      t.integer :fileset_id
      t.integer :ptf_id
      t.timestamps
    end
    execute "ALTER TABLE fileset_ptf_maps ADD CONSTRAINT
             unique_fileset_ptf_map_fileset_ptf UNIQUE (fileset_id, ptf_id)"
  end

  def self.down
    drop_table :fileset_ptf_maps
  end
end
