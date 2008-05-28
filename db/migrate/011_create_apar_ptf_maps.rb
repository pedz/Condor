class CreateAparPtfMaps < ActiveRecord::Migration
  def self.up
    create_table :apar_ptf_maps do |t|
      t.integer :apar_id
      t.integer :ptf_id
      t.timestamps
    end
    execute "ALTER TABLE apar_ptf_maps ADD CONSTRAINT
             unique_apar_ptf_map_apar_ptf UNIQUE (apar_id, ptf_id)"
  end

  def self.down
    drop_table :apar_ptf_maps
  end
end
