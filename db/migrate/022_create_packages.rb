# A package as found on the disk.  The sha1 should uniquely determine
# the package to a high probability.
class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :name, :null => false
      t.string :sha1, :null => false
      t.timestamps
    end
    execute "ALTER TABLE packages
             ADD CONSTRAINT unique_package_name
             UNIQUE (name, sha1)"
  end

  def self.down
    drop_table :packages
  end
end
