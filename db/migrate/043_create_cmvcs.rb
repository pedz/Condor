class CreateCmvcs < ActiveRecord::Migration
  def self.up
    create_table :cmvcs do |t|
      t.fk :user_id
      t.string :login, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :cmvcs
  end
end
