class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name, :null => false
      t.text :description
      t.boolean :private, :default => true
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
