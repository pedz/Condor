# Essentially these maps are produced from the pc_view input.  The
# exception is when a ptfapardef record specifies something that has
# not yet been seen in a pc_view record.
#
# While the pc_view has other data, it does not seem to be of use.
# In particular, the un-listed PTF field is not used.  In the pc_view
# it is just a PTF and there is not a release nor a fileset in the
# pc_view.  Subsequent calls to rp2 could be made to flush out the
# information but the belief is that eventually (perhaps even at the
# same time) the same information will be present in a ptfapardef
# record and the form in that record is far easier to work with.
class CreateAparDefectVersionMaps < ActiveRecord::Migration
  def self.up
    create_table :apar_defect_version_maps do |t|
      t.integer :apar_id,    :null => false
      t.integer :defect_id,  :null => false
      t.integer :version_id, :null => false
      t.timestamps
    end
    execute "ALTER TABLE apar_defect_version_maps
             ADD CONSTRAINT unique_apar_defect_version_map_apar_defect_version
             UNIQUE (apar_id, defect_id, version_id)"
    execute "ALTER TABLE apar_defect_version_maps
             ADD CONSTRAINT fk_apar_defect_version_maps_apar_id
             FOREIGN KEY (apar_id) REFERENCES apars(id)
             ON DELETE CASCADE DEFERRABLE"
    execute "ALTER TABLE apar_defect_version_maps
             ADD CONSTRAINT fk_apar_defect_version_maps_defect_id
             FOREIGN KEY (defect_id) REFERENCES defects(id)
             ON DELETE CASCADE DEFERRABLE"
    execute "ALTER TABLE apar_defect_version_maps
             ADD CONSTRAINT fk_apar_defect_version_maps_version_id
             FOREIGN KEY (version_id) REFERENCES versions(id)
             ON DELETE CASCADE DEFERRABLE"
    execute "CREATE INDEX apar_defect_version_maps_defect_idx
             ON apar_defect_version_maps(defect_id)"
    execute "CREATE INDEX apar_defect_version_maps_version_idx
             ON apar_defect_version_maps(version_id)"
  end

  def self.down
    execute "DROP INDEX apar_defect_version_maps_defect_idx"
    execute "DROP INDEX apar_defect_version_maps_version_idx"
    drop_table :apar_defect_version_maps
  end
end
