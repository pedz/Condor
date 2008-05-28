class CreateBases < ActiveRecord::Migration
  def self.up
    create_table :bases do |t|
      t.string :name
      t.timestamps
    end
    execute "ALTER TABLE bases ADD CONSTRAINT unique_base_name UNIQUE (name)"
  end

  def self.down
    drop_table :bases
  end
end
