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
    @task = Task.new
    @valid_task = Task.create!(@valid_attributes)
    @basic_task = Task.create!({:description => "value for description", :project_id => "1"})
  end

  it "should create a new instance given valid attributes" do
    @valid_task
  end

  it "should valid presence of description" do
    @task.should_not be_valid
    @task.should have(1).error_on(:description)
  end

  it "should valid presence of project" do
    @task.should_not be_valid
    @task.should have(1).error_on(:project_id)
  end

  it "should not change project" do
    @valid_task.project_id = "2"
    @valid_task.should_not be_valid
    @valid_task.should have(1).error_on(:project_id)
  end

  it "should not be a priority below the acceptable" do
    @task.priority = -1
    @task.should_not be_valid
    @task.should have(1).error_on(:priority)
  end

  it "should not be a priority over the acceptable" do
    @task.priority = 3
    @task.should have(1).error_on(:priority)
  end

  it "should validate when saving" do
    @task.save.should be_false
  end

  it "should validate when updating attributes" do
    @task.update_attributes({}).should be_false
    @task.update_attributes(@valid_attributes).should be_true
  end

  it "should find by id" do
    Task.find(@valid_task.id).should == @valid_task
  end

  it "should destroy by id" do
    lambda {
      Task.destroy(@valid_task.id)
    }.should change(Task, :count).by(-1)
  end

  it "should be active on create" do
    @basic_task.should be_active
  end

  it "should have normal priority (value 1) on create" do
    @basic_task.priority.should == 1
  end

  it "should be able to mark as done only if active" do
    @basic_task.mark_done
    @basic_task.should be_done
    @basic_task.done = false
    @basic_task.active = false
    @basic_task.mark_done
    @basic_task.should_not be_done
  end

  it "should be able to reopen only if active" do
    @basic_task.done = true
    @basic_task.reopen
    @basic_task.should_not be_done
    @basic_task.done = true
    @basic_task.active = false
    @basic_task.reopen
    @basic_task.should be_done
  end

  it "should be able to mark as feedback only if active" do
    @basic_task.mark_feedback
    @basic_task.should be_feedback
    @basic_task.feedback = false
    @basic_task.active = false
    @basic_task.mark_feedback
    @basic_task.should_not be_feedback
  end

  it "should be unmarkable as feedback" do
    @basic_task.feedback = true
    @basic_task.unmark_feedback
    @basic_task.should_not be_feedback
    @basic_task.feedback = true
    @basic_task.active = false
    @basic_task.unmark_feedback
    @basic_task.should be_feedback
  end

  it "should be able to activate and deactivate" do
    @basic_task.change_active
    @basic_task.should_not be_active
    @basic_task.change_active
    @basic_task.should be_active
  end

end