class Task < ActiveRecord::Base
  after_create :activity_on_create
#  before_destroy :activity_on_destroy
  belongs_to :project
  has_many :comments, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  validates_presence_of :description, :project_id
  validates_inclusion_of :priority, :in => 0..2
  named_scope :active, :conditions => 'active <> 0'

  def validate_on_update
    errors.add(:project_id, I18n.t("task.errors.project")) unless !attribute_changed?("project_id")
  end

  def mark_done
    self.done = true if (!self.done && self.active)
    activity = create_activity(
      :detail => "marcou a tarefa #{self.id} como concluída", 
      :action => "mark_done"
    )
    self.save
  end

  def reopen
    self.done = false if (self.done && self.active)
    activity = create_activity(
      :detail => "reabriu a tarefa #{self.id}", 
      :action => "reopen"
    )
    self.save
  end

  def request_feedback
    self.feedback = true if (!self.feedback && self.active)
    activity = create_activity(
      :detail => "pediu um feedback para a tarefa #{self.id}", 
      :action => "request_feedback"
    )
    self.save
  end

  def leave_feedback
    self.feedback = false if (self.feedback && self.active)
    activity = create_activity(
      :detail => "retirou o pedido de feedback da tarefa #{self.id}", 
      :action => "leave_feedback"
    )
    self.save
  end

  def deactive
    self.active = false
    activity = create_activity(
      :detail => "removeu a tarefa #{self.id}", 
      :action => "deactive"
    )
    self.save
  end

  def reactive
    self.active = true
    activity = create_activity(
      :detail => "reativou a tarefa #{self.id}", 
      :action => "reactive"
    )
    self.save
  end

  protected
    def create_activity(options = {})
      attributes = {
        :task_id => self.id, 
        :responsible_user => @current_user, 
        :time   => Time.now
      }.merge(options)
      return self.activities.build(attributes)
    end

    def activity_on_create
      activity = create_activity(
        :detail => "criou uma tarefa (#{self.id})",
        :action => "create_task"
      ).save
    end
end
