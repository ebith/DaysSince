class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name, :null => false
      t.string :uid, :null => false
      t.string :role, :null => false
      t.string :provider, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end