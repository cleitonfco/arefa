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

  it "should valid presence of project" do
    task = Task.new
    task.should_not be_valid
    task.should have(1).error_on(:project_id)
  end

  it "should not change project" do
    task = Task.create!(@valid_attributes)
    task.project_id = "2"
    task.should_not be_valid
    task.should have(1).error_on(:project_id)
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

  it "should validate when saving" do
    task = Task.new
    task.save.should be_false
  end

  it "should validate when updating attributes" do
    task = Task.new
    task.update_attributes({}).should be_false
    task.update_attributes(@valid_attributes).should be_true
  end

  it "should find by id" do
    task = Task.create!(@valid_attributes)
    Task.find(task.id).should == task
  end

  it "should destroy by id" do
    task = Task.create!(@valid_attributes)
    lambda {
      Task.destroy(task.id)
    }.should change(Task, :count).by(-1)
  end

end
