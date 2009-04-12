# The ptfapardef.constant files have a column which seems to be the
# stem of the lpp name.  I call it the lpp_base.  The lpp table has a
# reference to the lpp_base.
class CreateLppBases < ActiveRecord::Migration
  def self.up
    create_table :lpp_bases do |t|
      t.string :name, :null => false
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
