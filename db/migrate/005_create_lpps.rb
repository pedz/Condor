# Table of lpp names.  See notes in 004_create_lpp_bases.rb about lpp_base_id
class CreateLpps < ActiveRecord::Migration
  def self.up
    create_table :lpps do |t|
      t.string :name, :null => false
      t.integer :lpp_base_id, :null => false
      t.timestamps
    end
    execute "ALTER TABLE lpps
             ADD CONSTRAINT unique_lpp_name
             UNIQUE (name, lpp_base_id)" 
    execute "ALTER TABLE lpps
             ADD CONSTRAINT fk_lpps_lpp_base_id
             FOREIGN KEY (lpp_base_id) REFERENCES lpp_bases(id)
             ON DELETE CASCADE"
  end

  def self.down
    drop_table :lpps
  end
end
