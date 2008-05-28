class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.string :name
      t.integer :family_id
      t.timestamps
    end
    # Note that really, the name, id needs to be unique but I'm going
    # to make it just the name for now.
    execute "ALTER TABLE releases ADD CONSTRAINT unique_release_name UNIQUE (name)"
  end

  def self.down
    drop_table :releases
  end
end