class CreateFamilies < ActiveRecord::Migration
  def self.up
    create_table :families do |t|
      t.string :name
      t.timestamps
    end
    execute "ALTER TABLE families
             ADD CONSTRAINT unique_family_name
             UNIQUE (name)" 
  end

  def self.down
    drop_table :families
  end
end
