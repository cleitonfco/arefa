class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :task_id
      t.integer :responsible_user
      t.string :detail
      t.string :action
      t.datetime :time

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
