class CreateAixFiles < ActiveRecord::Migration
  def self.up
    create_table :aix_files do |t|
      t.string :path
      t.timestamps
    end
    execute "ALTER TABLE aix_files
             ADD CONSTRAINT unique_aix_files_path
             UNIQUE (path)"
  end

  def self.down
    drop_table :aix_files
  end
end
