class Task < ActiveRecord::Base
  validates_presence_of :description, :project_id
  validates_inclusion_of :priority, :in => 0..2

  def validate_on_update
    errors.add(:project_id, I18n.t("task.errors.project")) if ( self.project_id != @project_id ) 
  end

end
