class AddActiveToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :active, :boolean, :default => true
  end

  def self.down
    remove_column :tasks, :active
  end
end
