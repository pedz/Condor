# Its unfortunate but "release" has two meanings.  I believe
# everywhere in Condor, "release" will be a cmvc release and not a
# release such as "5.2", etc.
# From the ptfapardef records a release will always point to a family
# (although of questionable value).  To get the link from the
# ptfapardef records to the pc_view records, a release will also point
# to a version.  The version will be the ending substring of the
# release.  Currently all versions we care about are exactly three
# characters.
class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.string :name, :null => false
      t.integer :family_id, :null => false
      t.integer :version_id, :null => false
      t.timestamps
    end
    execute "ALTER TABLE releases
             ADD CONSTRAINT unique_release_name_family_id
             UNIQUE (name, family_id)"
    execute "ALTER TABLE releases
             ADD CONSTRAINT fk_releases_family_id
             FOREIGN KEY (family_id) REFERENCES families(id)
             ON DELETE CASCADE"
    execute "ALTER TABLE releases
             ADD CONSTRAINT fk_releases_version_id
             FOREIGN KEY (version_id) REFERENCES versions(id)
             ON DELETE CASCADE"
  end

  def self.down
    drop_table :releases
  end
end
