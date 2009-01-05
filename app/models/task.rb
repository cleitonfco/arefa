class Task < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :description, :project_id
  validates_inclusion_of :priority, :in => 0..2

  def validate_on_update
    errors.add(:project_id, I18n.t("task.errors.project")) unless !attribute_changed?("project_id")
  end

  def mark_done
    self.done = true if (!self.done && self.active)
  end

  def reopen
    self.done = false if (self.done && self.active)
  end

  def mark_feedback
    self.feedback = true if (!self.feedback && self.active)
  end

  def unmark_feedback
    self.feedback = false if (self.feedback && self.active)
  end

  def change_active
    self.active = !self.active
  end

end
