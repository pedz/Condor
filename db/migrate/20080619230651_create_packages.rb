class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :name
      t.timestamps
    end
    execute "ALTER TABLE packages
             ADD CONSTRAINT unique_package_name
             UNIQUE (name)"
  end

  def self.down
    drop_table :packages
  end
end
