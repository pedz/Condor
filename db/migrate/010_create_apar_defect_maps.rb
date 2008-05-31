class CreateAparDefectMaps < ActiveRecord::Migration
  def self.up
    create_table :apar_defect_maps do |t|
      t.integer :apar_id, :null => false
      t.integer :defect_id, :null => false

      t.timestamps
    end
    execute "ALTER TABLE apar_defect_maps
             ADD CONSTRAINT unique_apar_defect_map_apar_defect
             UNIQUE (apar_id, defect_id)"
    execute "CREATE INDEX apar_defect_maps_defect_idx
             ON apar_defect_maps(defect_id)"
    execute "ALTER TABLE apar_defect_maps
             ADD CONSTRAINT fk_apar_defect_maps_apar_id
             FOREIGN KEY (apar_id) REFERENCES apars(id)
             ON DELETE CASCADE"
    execute "ALTER TABLE apar_defect_maps
             ADD CONSTRAINT fk_apar_defect_maps_defect_id
             FOREIGN KEY (defect_id) REFERENCES defects(id)
             ON DELETE CASCADE"
  end

  def self.down
    execute "DROP INDEX apar_defect_maps_defect_idx"
    drop_table :apar_defect_maps
  end
end
