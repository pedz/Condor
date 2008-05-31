class CreateLpps < ActiveRecord::Migration
  def self.up
    create_table :lpps do |t|
      t.string :name
      t.integer :base_id, :null => false
      t.timestamps
    end
    execute "ALTER TABLE lpps
             ADD CONSTRAINT unique_lpp_name
             UNIQUE (name, base_id)" 
    execute "ALTER TABLE lpps
             ADD CONSTRAINT fk_lpps_base_id
             FOREIGN KEY (base_id) REFERENCES bases(id)
             ON DELETE CASCADE"
  end

  def self.down
    drop_table :lpps
  end
end
