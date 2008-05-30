class CreateDefects < ActiveRecord::Migration
  def self.up
    create_table :defects do |t|
      t.string :name
      t.timestamps
    end
    execute "ALTER TABLE defects
             ADD CONSTRAINT unique_defect_name
             UNIQUE (name)" 
  end

  def self.down
    drop_table :defects
  end
end
