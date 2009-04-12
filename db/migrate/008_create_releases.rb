class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.string :name
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
