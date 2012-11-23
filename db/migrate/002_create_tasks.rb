class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :uid
      t.string :value
      t.date :last_update
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
