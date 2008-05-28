class CreateAparPtfMaps < ActiveRecord::Migration
  def self.up
    create_table :apar_ptf_maps do |t|
      t.integer :apar_id
      t.integer :ptf_id

      t.timestamps
    end
  end

  def self.down
    drop_table :apar_ptf_maps
  end
end
