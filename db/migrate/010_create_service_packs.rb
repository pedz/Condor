# Currently this is not used any where but the name will be soemthing
# like "5.3 TL03 SP02".  I don't know yet of a reliable place to link
# this data in.  It may be that They are added by hand whenever a new
# set of PTFs come out.  But there is also the problem of PTFs that
# predate the service pack concept.
class CreateServicePacks < ActiveRecord::Migration
  def self.up
    create_table :service_packs do |t|
      t.string :name, :null => false
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