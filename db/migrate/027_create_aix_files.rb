class CreateAixFiles < ActiveRecord::Migration
  def self.up
    create_table :aix_files do |t|
      t.string :path
      t.timestamps
    end
    execute "ALTER TABLE aix_files
             ADD CONSTRAINT unique_aix_files_path
             UNIQUE (path)"
    execute "CREATE INDEX base_file_name_idx ON aix_files(basename(path));"
  end

  def self.down
    execute "DROP INDEX base_file_name_idx;"
    drop_table :aix_files
  end
end
