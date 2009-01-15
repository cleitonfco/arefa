class Activity < ActiveRecord::Base
  belongs_to :task
  belongs_to :comment
  belongs_to :user, :foreign_key => :responsible_user
  before_save :auto_time
  validates_presence_of :task_id, :detail, :action

  def auto_time
    self.time = Time.now if self.time.nil?
  end

end
