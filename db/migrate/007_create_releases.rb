class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.string :name
      t.integer :family_id
      t.timestamps
    end
    execute "ALTER TABLE releases
             ADD CONSTRAINT unique_release_name
             UNIQUE (name, family_id)"
  end

  def self.down
    drop_table :releases
  end
end
