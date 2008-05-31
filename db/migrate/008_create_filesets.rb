class CreateFilesets < ActiveRecord::Migration
  def self.up
    create_table :filesets do |t|
      t.integer :lpp_id, :null => false
      t.string :vrmf
      t.timestamps
    end
    execute "ALTER TABLE filesets
             ADD CONSTRAINT unique_fileset_lpp_id_vrmf
             UNIQUE (lpp_id, vrmf)"
  end

  def self.down
    drop_table :filesets
  end
end
