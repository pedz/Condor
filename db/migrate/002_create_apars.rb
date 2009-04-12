# Table for APARs
# Note that abstract may be null (which sucks) but in the case that
# the APAR is found first via a pc_view record, the abstract is not
# known.  We later fill it in when we find the ptfapardef record.
class CreateApars < ActiveRecord::Migration
  def self.up
    create_table :apars do |t|
      t.string :name, :null => false
      t.string :abstract
      t.timestamps
    end
    execute "ALTER TABLE apars
             ADD CONSTRAINT unique_apar_name
             UNIQUE (name)" 
  end

  def self.down
    drop_table :apars
  end
end
