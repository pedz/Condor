class CreateServicePacks < ActiveRecord::Migration
  def self.up
    create_table :service_packs do |t|
      t.string :name
      t.timestamps
    end
    execute "ALTER TABLE service_packs
             ADD CONSTRAINT unique_service_pack_name
             UNIQUE (name)"
  end

  def self.down
    drop_table :service_packs
  end
end
