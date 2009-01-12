class AddCommentToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :comment_id, :integer
  end

  def self.down
    remove_column :activities, :comment_id
  end
end
