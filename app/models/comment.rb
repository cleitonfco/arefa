class Comment < ActiveRecord::Base
#  after_create :activity_on_create
  belongs_to :task
  has_many :activities

#  def activity_on_create
#    activity = self.task.activities.build!(
#      :task_id => self.task.id, 
#      :responsible_user => @current_user, 
#      :detail => "adicionou um comentário", 
#      :comment_id => self.id, 
#      :action => "add_comment", 
#      :time => self.created_at
#    )
#    activity.save
#  end
end
