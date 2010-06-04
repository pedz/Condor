class CreateCmvcs < ActiveRecord::Migration
  def self.up
    create_table :cmvcs do |t|
      t.fk :user_id, :unique => true
      t.string :login, :null => false, :unique => true
      t.timestamps
    end
  end

  def self.down
    drop_table :cmvcs
  end
end
