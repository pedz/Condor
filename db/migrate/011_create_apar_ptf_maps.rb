class CreateAparPtfMaps < ActiveRecord::Migration
  def self.up
    create_table :apar_ptf_maps do |t|
      t.integer :apar_id, :null => false
      t.integer :ptf_id, :null => false
      t.timestamps
    end
    execute "ALTER TABLE apar_ptf_maps
             ADD CONSTRAINT unique_apar_ptf_map_apar_ptf
             UNIQUE (apar_id, ptf_id)"
    execute "CREATE INDEX apar_ptf_maps_ptf_idx
             ON apar_ptf_maps(ptf_id)"
  end

  def self.down
    execute "DROP INDEX apar_ptf_maps_ptf_idx"
    drop_table :apar_ptf_maps
  end
end
