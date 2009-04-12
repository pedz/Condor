# The 7th field in a ptfapardef.constant record I call 'family' -- I
# have no idea why.  It appears to be completely useless.
class CreateFamilies < ActiveRecord::Migration
  def self.up
    create_table :families do |t|
      t.string :name, :null => false
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
