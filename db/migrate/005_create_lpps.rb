class CreateLpps < ActiveRecord::Migration
  def self.up
    create_table :lpps do |t|
      t.string :name
      t.integer :base_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lpps
  end
end
