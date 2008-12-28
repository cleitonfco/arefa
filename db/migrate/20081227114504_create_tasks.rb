class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :description, :null => false
      t.integer :project_id
      t.boolean :done, :default => false
      t.boolean :feedback, :default => false
      t.integer :priority, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
