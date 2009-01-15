class Comment < ActiveRecord::Base
  after_create :activity_on_create
  belongs_to :task
  has_many :activities

  def activity_on_create
      self.activities.build(
        :task_id => self.task_id, 
        :responsible_user => @current_user, 
        :time => Time.now, 
        :detail => "adicionou um comentário à tarefa #{self.task_id}",
        :action => "add_comment", 
        :comment_id => self.id
      ).save
  end
end
