require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Activity do
  def activity_attributes(options = {})
    {
      :task_id => "1",
      :responsible_user => "1",
      :detail => "value for detail",
      :action => "value for action",
      :time => Time.now
    }.merge(options)
  end

  before(:each) do
    @activity = Activity.new
  end

  it "should create a new instance given valid attributes" do
    Activity.create!(activity_attributes)
  end
end
