require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TasksController do

  def mock_tasks(stubs={})
    @mock_tasks ||= mock_model(Tasks, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all tasks as @tasks" do
      Tasks.should_receive(:find).with(:all).and_return([mock_tasks])
      get :index
      assigns[:tasks].should == [mock_tasks]
    end

    describe "with mime type of xml" do
  
      it "should render all tasks as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Tasks.should_receive(:find).with(:all).and_return(tasks = mock("Array of Tasks"))
        tasks.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested tasks as @tasks" do
      Tasks.should_receive(:find).with("37").and_return(mock_tasks)
      get :show, :id => "37"
      assigns[:tasks].should equal(mock_tasks)
    end
    
    describe "with mime type of xml" do

      it "should render the requested tasks as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Tasks.should_receive(:find).with("37").and_return(mock_tasks)
        mock_tasks.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new tasks as @tasks" do
      Tasks.should_receive(:new).and_return(mock_tasks)
      get :new
      assigns[:tasks].should equal(mock_tasks)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested tasks as @tasks" do
      Tasks.should_receive(:find).with("37").and_return(mock_tasks)
      get :edit, :id => "37"
      assigns[:tasks].should equal(mock_tasks)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created tasks as @tasks" do
        Tasks.should_receive(:new).with({'these' => 'params'}).and_return(mock_tasks(:save => true))
        post :create, :tasks => {:these => 'params'}
        assigns(:tasks).should equal(mock_tasks)
      end

      it "should redirect to the created tasks" do
        Tasks.stub!(:new).and_return(mock_tasks(:save => true))
        post :create, :tasks => {}
        response.should redirect_to(task_url(mock_tasks))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved tasks as @tasks" do
        Tasks.stub!(:new).with({'these' => 'params'}).and_return(mock_tasks(:save => false))
        post :create, :tasks => {:these => 'params'}
        assigns(:tasks).should equal(mock_tasks)
      end

      it "should re-render the 'new' template" do
        Tasks.stub!(:new).and_return(mock_tasks(:save => false))
        post :create, :tasks => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested tasks" do
        Tasks.should_receive(:find).with("37").and_return(mock_tasks)
        mock_tasks.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :tasks => {:these => 'params'}
      end

      it "should expose the requested tasks as @tasks" do
        Tasks.stub!(:find).and_return(mock_tasks(:update_attributes => true))
        put :update, :id => "1"
        assigns(:tasks).should equal(mock_tasks)
      end

      it "should redirect to the tasks" do
        Tasks.stub!(:find).and_return(mock_tasks(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(task_url(mock_tasks))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested tasks" do
        Tasks.should_receive(:find).with("37").and_return(mock_tasks)
        mock_tasks.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :tasks => {:these => 'params'}
      end

      it "should expose the tasks as @tasks" do
        Tasks.stub!(:find).and_return(mock_tasks(:update_attributes => false))
        put :update, :id => "1"
        assigns(:tasks).should equal(mock_tasks)
      end

      it "should re-render the 'edit' template" do
        Tasks.stub!(:find).and_return(mock_tasks(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested tasks" do
      Tasks.should_receive(:find).with("37").and_return(mock_tasks)
      mock_tasks.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the tasks list" do
      Tasks.stub!(:find).and_return(mock_tasks(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(tasks_url)
    end

  end

end
