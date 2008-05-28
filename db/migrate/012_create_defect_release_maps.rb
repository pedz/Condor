class CreateDefectReleaseMaps < ActiveRecord::Migration
  def self.up
    create_table :defect_release_maps do |t|
      t.integer :defect_id
      t.integer :release_id
      t.timestamps
    end
    execute "ALTER TABLE defect_release_maps ADD CONSTRAINT
             unique_defect_release_map_defect_release UNIQUE (defect_id, release_id)"
  end

  def self.down
    drop_table :defect_release_maps
  end
end
