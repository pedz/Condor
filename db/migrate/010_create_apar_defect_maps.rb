class CreateAparDefectMaps < ActiveRecord::Migration
  def self.up
    create_table :apar_defect_maps do |t|
      t.integer :apar_id
      t.integer :defect_id

      t.timestamps
    end
    execute "ALTER TABLE apar_defect_maps ADD CONSTRAINT
             unique_apar_defect_map_apar_defect UNIQUE (apar_id, defect_id)"
  end

  def self.down
    drop_table :apar_defect_maps
  end
end
