class Project < ActiveRecord::Base
  has_many :tasks
  belongs_to :user
  validates_presence_of :name
  named_scope :user, lambda { |user| { :conditions => ['user_id = ?', user] } }

  def deactive
    self.active = false
    self.save
  end

  def reactive
    self.active = true
    self.save
  end

end
