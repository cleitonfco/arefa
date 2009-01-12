require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper

describe TasksController do
  
  def mock_task(stubs={})
    stubs.merge(:project_id => @project.id) if stubs[:project_id].nil?
    @mock_task ||= mock_model(Task, stubs)
  end
  
  before(:each) do
    admin_login
    @project = mock_model(Project, :id => "1")
    Project.should_receive(:find).with(@project.id).and_return(@project)
    @project.stub!(:tasks).and_return([mock_task])
    @project.tasks.stub!(:active).and_return([mock_task])
  end

  describe "responding to GET index" do

    it "should expose all tasks as @tasks" do
      @project.tasks.active.should_receive(:find).with(:all).and_return([mock_task])
      get :index, :project_id => @project.id
      assigns[:tasks].should == [mock_task]
      response.layout.should == 'layouts/general'
    end

    describe "with mime type of xml" do

      it "should render all tasks as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        @project.tasks.active.should_receive(:find).with(:all).and_return(tasks = mock("Array of Tasks"))
        tasks.should_receive(:to_xml).and_return("generated XML")
        get :index, :project_id => @project.id
        response.body.should == "generated XML"
      end

    end

  end

  describe "responding to GET show" do

    before(:each) do
      mock_task.stub!(:comments).and_return(mock_model(Comment))
      mock_task.comments.should_receive(:find).with(:all).and_return([mock_model(Comment)])
      mock_task.comments.stub!(:build).and_return(mock_model(Comment))
    end

    it "should expose the requested task as @task" do
      @project.tasks.active.should_receive(:find).with("37").and_return(mock_task)
      get :show, :id => "37", :project_id => @project.id
      assigns[:task].should equal(mock_task)
      response.layout.should == 'layouts/general'
    end
    
    describe "with mime type of xml" do

      it "should render the requested task as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        @project.tasks.active.should_receive(:find).with("37").and_return(mock_task)
        mock_task.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37", :project_id => @project.id
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do

    it "should expose a new task as @task" do
      @project.tasks.should_receive(:build).and_return(mock_task)
      get :new, :project_id => @project.id
      assigns[:task].should equal(mock_task)
      response.layout.should == 'layouts/general'
    end

  end

  describe "responding to GET edit" do

    it "should expose the requested task as @task" do
      @project.tasks.active.should_receive(:find).with("37").and_return(mock_task)
      get :edit, :id => "37", :project_id => @project.id
      assigns[:task].should equal(mock_task)
      response.layout.should == 'layouts/general'
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      before(:each) do
        mock_task.stub!(:save).and_return(true)
      end

      it "should expose a newly created task as @task" do
        @project.tasks.should_receive(:build).with({'these' => 'params'}).and_return(mock_task)
        post :create, :task => {:these => 'params'}, :project_id => @project.id
        assigns(:task).should equal(mock_task)
      end

      it "should redirect to the created task" do
        @project.tasks.stub!(:build).and_return(mock_task)
        post :create, :task => {}, :project_id => @project.id
        response.should redirect_to(project_task_url(@project, mock_task))
      end
      
    end
    
    describe "with invalid params" do

      before(:each) do
        mock_task.stub!(:save).and_return(false)
      end

      it "should expose a newly created but unsaved task as @task" do
        @project.tasks.stub!(:build).with({'these' => 'params'}).and_return(mock_task)
        post :create, :task => {:these => 'params'}, :project_id => @project.id
        assigns(:task).should equal(mock_task)
      end

      it "should re-render the 'new' template" do
        @project.tasks.stub!(:build).and_return(mock_task)
        post :create, :task => {}, :project_id => @project.id
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT update" do

    describe "with valid params" do

      it "should update the requested task" do
        @project.tasks.should_receive(:find).with("37").and_return(mock_task)
        mock_task.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :task => {:these => 'params'}, :project_id => @project.id
      end

      it "should expose the requested task as @task" do
        mock_task.stub!(:update_attributes).and_return(true)
        @project.tasks.stub!(:find).and_return(mock_task)
        put :update, :id => "1", :project_id => @project.id
        assigns(:task).should equal(mock_task)
      end

      it "should redirect to the task" do
        mock_task.stub!(:update_attributes).and_return(true)
        @project.tasks.stub!(:find).and_return(mock_task)
        put :update, :id => "1", :project_id => @project.id
        response.should redirect_to(project_task_url(@project, mock_task))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested task" do
        @project.tasks.should_receive(:find).with("37").and_return(mock_task)
        mock_task.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :task => {:these => 'params'}, :project_id => @project.id
      end

      it "should expose the task as @task" do
        mock_task.stub!(:update_attributes).and_return(false)
        @project.tasks.stub!(:find).and_return(mock_task(:update_attributes => false))
        put :update, :id => "1", :project_id => @project.id
        assigns(:task).should equal(mock_task)
      end

      it "should re-render the 'edit' template" do
        mock_task.stub!(:update_attributes).and_return(false)
        @project.tasks.stub!(:find).and_return(mock_task)
        put :update, :id => "1", :project_id => @project.id
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested task" do
      @project.tasks.active.should_receive(:find).with("37").and_return(mock_task)
      mock_task.stub!(:deactive).and_return(true)
      delete :destroy, :id => "37", :project_id => @project.id
    end

    it "should redirect to the tasks list" do
      mock_task.stub!(:deactive).and_return(true)
      @project.tasks.active.stub!(:find).and_return(mock_task)
      delete :destroy, :id => "1", :project_id => @project.id
      response.should redirect_to(project_tasks_url(@project))
    end

  end

end
