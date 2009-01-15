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

  it "should valid presence of task" do
    @activity.should_not be_valid
    @activity.should have(1).error_on(:task_id)
  end

  it "should valid presence of detail" do
    @activity.should_not be_valid
    @activity.should have(1).error_on(:detail)
  end

  it "should valid presence of action" do
    @activity.should_not be_valid
    @activity.should have(1).error_on(:action)
  end

  it "should have time now on create" do
    time_now = Time.new
    Time.stub!(:now).and_return(time_now)

    activity = Activity.create!(:task_id => "1",
      :responsible_user => "1",
      :detail => "value for detail",
      :action => "value for action")
    activity.time.should == Time.now
  end

end
