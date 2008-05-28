class CreateAparDefectMaps < ActiveRecord::Migration
  def self.up
    create_table :apar_defect_maps do |t|
      t.integer :apar_id
      t.integer :defect_id

      t.timestamps
    end
  end

  def self.down
    drop_table :apar_defect_maps
  end
end
