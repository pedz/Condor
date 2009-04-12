# Table for PTFs
class CreatePtfs < ActiveRecord::Migration
  def self.up
    create_table :ptfs do |t|
      t.string :name, :null => false
      t.timestamps
    end
    execute "ALTER TABLE ptfs
             ADD CONSTRAINT unique_ptf_name
             UNIQUE (name)"
  end

  def self.down
    drop_table :ptfs
  end
end
