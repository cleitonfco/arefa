require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Task do
  before(:each) do
    @valid_attributes = {
      :description => "value for description",
      :project_id => "1",
      :done => false,
      :feedback => false,
      :priority => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    Task.create!(@valid_attributes)
  end

  it "should valid presence of description" do
    task = Task.new
    task.should_not be_valid
    task.should have(1).error_on(:description)
  end

  it "should not be a priority below the acceptable" do
    task = Task.new
    task.priority = -1
    task.should_not be_valid
    task.should have(1).error_on(:priority)
  end

  it "should not be a priority over the acceptable" do
    task = Task.new
    task.priority = 3
    task.should have(1).error_on(:priority)
  end

end
