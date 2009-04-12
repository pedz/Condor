class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.string :name
      t.timestamps
    end
    execute "ALTER TABLE versions
             ADD CONSTRAINT unique_version_name
             UNIQUE (name)"
  end

  def self.down
    drop_table :versions
  end
end
