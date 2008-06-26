class CreateLppBases < ActiveRecord::Migration
  def self.up
    create_table :lpp_bases do |t|
      t.string :name
      t.timestamps
    end
    execute "ALTER TABLE lpp_bases
             ADD CONSTRAINT unique_lpp_base_name
             UNIQUE (name)" 
  end

  def self.down
    drop_table :lpp_bases
  end
end
