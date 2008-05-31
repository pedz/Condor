class CreateFilesetPtfMaps < ActiveRecord::Migration
  def self.up
    create_table :fileset_ptf_maps do |t|
      t.integer :fileset_id, :null => false
      t.integer :ptf_id, :null => false
      t.timestamps
    end
    execute "ALTER TABLE fileset_ptf_maps
             ADD CONSTRAINT unique_fileset_ptf_map_fileset_ptf
             UNIQUE (fileset_id, ptf_id)"
    execute "CREATE INDEX fileset_ptf_maps_ptf_idx
             ON fileset_ptf_maps(ptf_id);"
  end

  def self.down
    execute "DROP INDEX fileset_ptf_maps_ptf_idx"
    drop_table :fileset_ptf_maps
  end
end
