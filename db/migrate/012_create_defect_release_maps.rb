class CreateDefectReleaseMaps < ActiveRecord::Migration
  def self.up
    create_table :defect_release_maps do |t|
      t.integer :defect_id
      t.integer :release_id

      t.timestamps
    end
  end

  def self.down
    drop_table :defect_release_maps
  end
end
