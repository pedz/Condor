class CreateFilesets < ActiveRecord::Migration
  def self.up
    create_table :filesets do |t|
      t.integer :lpp_id
      t.string :vrmf

      t.timestamps
    end
  end

  def self.down
    drop_table :filesets
  end
end
