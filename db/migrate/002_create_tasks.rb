class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :uid, :null => false
      t.string :value, :null => false
      t.date :last_update, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
