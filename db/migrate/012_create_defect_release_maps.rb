class CreateDefectReleaseMaps < ActiveRecord::Migration
  def self.up
    create_table :defect_release_maps do |t|
      t.integer :defect_id, :null => false
      t.integer :release_id, :null => false
      t.timestamps
    end
    execute "ALTER TABLE defect_release_maps
             ADD CONSTRAINT unique_defect_release_map_defect_release
             UNIQUE (defect_id, release_id)"
    execute "CREATE INDEX defect_release_maps_release_idx
             ON defect_release_maps(release_id);"
    execute "ALTER TABLE defect_release_maps
             ADD CONSTRAINT fk_defect_release_maps_defect_id
             FOREIGN KEY (defect_id) REFERENCES defects(id)
             ON DELETE CASCADE"
    execute "ALTER TABLE defect_release_maps
             ADD CONSTRAINT fk_defect_release_maps_release_id
             FOREIGN KEY (release_id) REFERENCES releases(id)
             ON DELETE CASCADE"
  end

  def self.down
    execute "DROP INDEX defect_release_maps_release_idx"
    drop_table :defect_release_maps
  end
end
