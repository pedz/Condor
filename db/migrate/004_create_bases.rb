class CreateBases < ActiveRecord::Migration
  def self.up
    create_table :bases do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :bases
  end
end
