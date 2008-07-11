class CreateAparDefectPtfReleaseMaps < ActiveRecord::Migration
  def self.up
    create_table :apar_defect_ptf_release_maps do |t|
      t.integer :apar_id
      t.integer :defect_id
      t.integer :ptf_id
      t.integer :release_id

      t.timestamps
    end
  end

  def self.down
    drop_table :apar_defect_ptf_release_maps
  end
end
