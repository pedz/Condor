class CreateLpps < ActiveRecord::Migration
  def self.up
    create_table :lpps do |t|
      t.string :name
      t.integer :base_id
      t.timestamps
    end
    execute "ALTER TABLE lpps ADD CONSTRAINT unique_lpp_name UNIQUE (name)"
  end

  def self.down
    drop_table :lpps
  end
end
