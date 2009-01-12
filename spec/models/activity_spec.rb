require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Activity do
  before(:each) do
    @valid_attributes = {
      :task_id => "1",
      :responsible_user => "1",
      :detail => "value for detail",
      :action => "value for action",
      :time => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Activity.create!(@valid_attributes)
  end
end
