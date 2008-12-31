class Project < ActiveRecord::Base
  validates_presence_of :name

  def change_active
    self.active = !self.active
  end

end