require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Task do
  def task_attributes(options = {})
    {
      :description => "value for description",
      :project_id => "1",
      :done => false,
      :feedback => false,
      :priority => "1"
    }.merge(options)
  end

  before(:each) do
    @task = Task.new
    @basic_attributes = {:description => "value for description", :project_id => "1"}
  end

  it "should create a new instance given valid attributes" do
    Task.create!(task_attributes)
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
    task = Task.create!(@basic_attributes)
    task.attributes = {:project_id => "2"}
    task.should_not be_valid
    task.should have(1).error_on(:project_id)
  end

  it "should update when haven't project" do
    @task.attributes = task_attributes({:description => "other value for description", :done => true})
    @task.should be_valid
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
    @task.update_attributes(task_attributes).should be_true
  end

  it "should get actives only with named scope" do
    task1 = Task.create!(task_attributes)
    task2 = Task.create!(task_attributes(:active => false))
    Task.active.find(:all).should == [task1]
  end

  it "should find by id" do
    @task.attributes = task_attributes
    @task.save.should be_true
    Task.find(@task.id).should == @task
  end

  it "should be active on create" do
    task = Task.create!(@basic_attributes)
    task.should be_active
  end

  it "should not be done on create" do
    task = Task.create!(@basic_attributes)
    task.should_not be_done
  end

  it "should not be feedback on create" do
    task = Task.create!(@basic_attributes)
    task.should_not be_feedback
  end

  it "should have normal priority (value 1) on create" do
    task = Task.create!(@basic_attributes)
    task.priority.should == 1
  end

  it "should create a activity on create" do
    task = Task.create!(@basic_attributes)
    activity = Activity.find_by_task_id_and_action(task.id, "create_task")
    activity.detail.should == "criou uma tarefa (#{task.id})"
  end

  describe "NOT DONE" do

    it "should be markable as done definitely (when active)" do
      task = Task.create!(@basic_attributes)
      task.mark_done
      Task.find(task.id).should be_done
      task.attributes = {:done => false, :active => false}
      task.mark_done
      Task.find(task.id).should_not be_done
    end

    it "should create a activity when mark as done" do
      task = Task.create!(@basic_attributes)
      task.mark_done
      activity = Activity.find_by_task_id_and_action(task.id, "mark_done")
      activity.detail.should == "marcou a tarefa #{task.id} como concluída"
    end

  end

  describe "DONE" do

    it "should be able to reopen definitely (when active)" do
      task = Task.create!(@basic_attributes.merge(:done => true))
      task.reopen
      Task.find(task.id).should_not be_done
      task.attributes = {:done => true, :active => false}
      task.reopen
      Task.find(task.id).should be_done
    end

    it "should create a activity when reopen" do
      task = Task.create!(@basic_attributes)
      task.reopen
      activity = Activity.find_by_task_id_and_action(task.id, "reopen")
      activity.detail.should == "reabriu a tarefa #{task.id}"
    end

  end

  describe "WITHOUT FEEDBACK" do

    it "should be able to request feedback definitely (when active)" do
      task = Task.create!(@basic_attributes)
      task.request_feedback
      Task.find(task.id).should be_feedback
      task.attributes = {:feedback => false, :active => false}
      task.request_feedback
      Task.find(task.id).should_not be_feedback
    end

    it "should create a activity when request feedback" do
      task = Task.create!(@basic_attributes)
      task.request_feedback
      activity = Activity.find_by_task_id_and_action(task.id, "request_feedback")
      activity.detail.should == "pediu um feedback para a tarefa #{task.id}"
    end

  end

  describe "WITH FEEDBACK" do

    it "should be able to leave feedback definitely" do
      task = Task.create!(@basic_attributes.merge(:feedback => true))
      task.leave_feedback
      Task.find(task.id).should_not be_feedback
      task.attributes = {:feedback => true, :active => false}
      task.leave_feedback
      Task.find(task.id).should be_feedback
    end

    it "should create a activity when leave feedback" do
      task = Task.create!(@basic_attributes)
      task.leave_feedback
      activity = Activity.find_by_task_id_and_action(task.id, "leave_feedback")
      activity.detail.should == "retirou o pedido de feedback da tarefa #{task.id}"
    end

  end

  describe "ACTIVE" do

    it "should be deactivable definitely" do
      task = Task.create!(@basic_attributes)
      task.deactive
      Task.find(task.id).should_not be_active
    end

    it "should create a activity when deactiving" do
      task = Task.create!(@basic_attributes)
      task.deactive
      activity = Activity.find_by_task_id_and_action(task.id, "deactive")
      activity.detail.should == "removeu a tarefa #{task.id}"
    end

  end

  describe "NOT ACTIVE" do

    it "should be reactivable definitely" do
      task = Task.create!(@basic_attributes.merge(:active => false))
      task.reactive
      Task.find(task.id).should be_active
    end

    it "should create a activity when deactiving" do
      task = Task.create!(@basic_attributes.merge(:active => false))
      task.reactive
      activity = Activity.find_by_task_id_and_action(task.id, "reactive")
      activity.detail.should == "reativou a tarefa #{task.id}"
    end

  end

end
