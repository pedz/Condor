# These maps are produced from the ptfapardef records.  The first
# piece is the apar, defect, version mapping.  This is usually created
# before this mapping.  The creation process for this mapping first
# finds the apar_defect_version_map.  This is done by taking the apar
# and defect from the ptfapardef record.  The release in the record is
# mapped to a version by taking the last three characters of the
# release's name.  The apar_defect_version_map is then found or
# created if needed.  Its id is then used in this record along with
# the other ids.  There is a small bit of duplicate information in
# that the release points to a version.  The version can also be found
# by going to the apar_defect_version_map.  So... in theory only the
# release's leading characters should be saved...
class CreateAdvPtfReleaseMaps < ActiveRecord::Migration
  def self.up
    create_table :adv_ptf_release_maps do |t|
      t.integer :apar_defect_version_map_id, :null => false
      t.integer :ptf_id,                     :null => false
      t.integer :release_id,                 :null => false
      t.timestamps
    end
    execute "ALTER TABLE adv_ptf_release_maps
             ADD CONSTRAINT unique_adv_ptf_release_map_adv_ptf_release
             UNIQUE (apar_defect_version_map_id, ptf_id, release_id)"
    execute "ALTER TABLE adv_ptf_release_maps
             ADD CONSTRAINT fk_adv_ptf_release_maps_apar_defect_version_map_id
             FOREIGN KEY (apar_defect_version_map_id) REFERENCES apar_defect_version_maps(id)
             ON DELETE CASCADE"
    execute "ALTER TABLE adv_ptf_release_maps
             ADD CONSTRAINT fk_adv_ptf_release_maps_ptf_id
             FOREIGN KEY (ptf_id) REFERENCES ptfs(id)
             ON DELETE CASCADE"
    execute "ALTER TABLE adv_ptf_release_maps
             ADD CONSTRAINT fk_adv_ptf_release_maps_release_id
             FOREIGN KEY (release_id) REFERENCES releases(id)
             ON DELETE CASCADE"
    execute "CREATE INDEX adv_ptf_release_maps_apar_defect_version_map_idx
             ON adv_ptf_release_maps(apar_defect_version_map_id)"
    execute "CREATE INDEX adv_ptf_release_maps_ptf_idx
             ON adv_ptf_release_maps(ptf_id)"
    execute "CREATE INDEX adv_ptf_release_maps_release_idx
             ON adv_ptf_release_maps(release_id)"
  end

  def self.down
    execute "DROP INDEX adv_ptf_release_maps_apar_defect_version_map_idx"
    execute "DROP INDEX adv_ptf_release_maps_ptf_idx"
    execute "DROP INDEX adv_ptf_release_maps_release_idx"
    drop_table :adv_ptf_release_maps
  end
end
