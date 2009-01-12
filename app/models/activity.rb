class Activity < ActiveRecord::Base
  belongs_to :task
  belongs_to :comment
  belongs_to :user, :foreign_key => :responsible_user
end
