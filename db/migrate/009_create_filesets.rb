# A fileset is distinguished by the lpp name and the vrmf.  Just to
# repeat it here, a package is a group of filesets (not the other way
# around).  And a fileset is a group of files which I call aix_paths.
class CreateFilesets < ActiveRecord::Migration
  def self.up
    create_table :filesets do |t|
      t.integer :lpp_id, :null => false
      t.string :vrmf, :null => false
      t.timestamps
    end
    execute "ALTER TABLE filesets
             ADD CONSTRAINT unique_fileset_lpp_id_vrmf
             UNIQUE (lpp_id, vrmf)"
    execute "ALTER TABLE filesets
             ADD CONSTRAINT fk_filesets_lpp_id
             FOREIGN KEY (lpp_id) REFERENCES lpps(id)
             ON DELETE CASCADE DEFERRABLE"
  end

  def self.down
    drop_table :filesets
  end
end
