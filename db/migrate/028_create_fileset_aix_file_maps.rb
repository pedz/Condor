# A fileset ships many files.  But if only one file changes, the next
# fileset will ship many of the same files.  Thus there is a many to
# many mapping between AIX files and filesets.  This map provides that
# mapping.
class CreateFilesetAixFileMaps < ActiveRecord::Migration
  def self.up
    create_table :fileset_aix_file_maps do |t|
      t.integer :fileset_id,  :null => false
      t.integer :aix_file_id, :null => false
      t.timestamps
    end
    execute "ALTER TABLE fileset_aix_file_maps
             ADD CONSTRAINT unique_fileset_aix_file_map_fileset_aix_file
             UNIQUE (fileset_id, aix_file_id)"
    execute "ALTER TABLE fileset_aix_file_maps
             ADD CONSTRAINT fk_fileset_aix_file_maps_fileset_id
             FOREIGN KEY (fileset_id) REFERENCES filesets(id)
             ON DELETE CASCADE"
    execute "ALTER TABLE fileset_aix_file_maps
             ADD CONSTRAINT fk_fileset_aix_file_maps_aix_file_id
             FOREIGN KEY (aix_file_id) REFERENCES aix_files(id)
             ON DELETE CASCADE"
  end

  def self.down
    drop_table :fileset_aix_file_maps
  end
end
