class Project < ActiveRecord::Base
  has_many :tasks
  validates_presence_of :name

  def change_active
    self.active = !self.active
  end

end