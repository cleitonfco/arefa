class Task < ActiveRecord::Base
  validates_presence_of :description
  validates_inclusion_of :priority, :in => 0..2
end
