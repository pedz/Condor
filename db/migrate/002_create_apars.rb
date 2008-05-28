class CreateApars < ActiveRecord::Migration
  def self.up
    create_table :apars do |t|
      t.string :name
      t.string :abstract

      t.timestamps
    end
  end

  def self.down
    drop_table :apars
  end
end
