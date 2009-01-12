require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController do

  def mock_comment(stubs={})
    @mock_comment ||= mock_model(Comment, stubs)
  end
  
  before(:each) do
    @project = mock_model(Project, :id => "1")
    @task = mock_model(Task, :id => "1")
    Project.should_receive(:find).with(@project.id).and_return(@project)
    Task.should_receive(:find).with(@task.id).and_return(@task)
    @task.stub!(:comments).and_return([mock_comment])
  end

  #describe "responding to GET new" do
  #
  #  it "should expose a new comment as @comment" do
  #    @task.comments.should_receive(:build).and_return(mock_comment)
  #    get :new, :task_id => @task.id
  #    assigns[:comment].should equal(mock_comment)
  #  end
  #
  #end

  describe "responding to POST create" do

    describe "with valid params" do
      
      before(:each) do
        mock_comment.stub!(:save).and_return(true)
      end

      it "should expose a newly created comment as @comment" do
        @task.comments.should_receive(:build).with({'these' => 'params'}).and_return(mock_comment)
        post :create, :comment => {:these => 'params'}, :task_id => @task.id, :project_id => @project.id
        assigns(:comment).should equal(mock_comment)
      end

      it "should redirect to the created comment" do
        @task.comments.should_receive(:build).and_return(mock_comment)
        post :create, :comment => {}, :task_id => @task.id, :project_id => @project.id
        response.should redirect_to(project_task_url(@project, @task))
      end
      
    end
    
    describe "with invalid params" do

      before(:each) do
        mock_comment.stub!(:save).and_return(false)
      end

      it "should expose a newly created but unsaved comment as @comment" do
        @task.comments.should_receive(:build).with({'these' => 'params'}).and_return(mock_comment)
        post :create, :comment => {:these => 'params'}, :task_id => @task.id, :project_id => @project.id
        assigns(:comment).should equal(mock_comment)
      end

      it "should re-render the 'new' template" do
        @task.comments.should_receive(:build).and_return(mock_comment)
        post :create, :comment => {}, :task_id => @task.id, :project_id => @project.id
        response.should render_template('new')
      end
      
    end
    
  end

  #describe "responding to DELETE destroy" do
  #
  #  it "should destroy the requested comment" do
  #    Comment.should_receive(:find).with("37").and_return(mock_comment)
  #    mock_comment.should_receive(:destroy)
  #    delete :destroy, :id => "37"
  #  end
  #
  #  it "should redirect to the comments list" do
  #    Comment.stub!(:find).and_return(mock_comment(:destroy => true))
  #    delete :destroy, :id => "1"
  #    response.should redirect_to(comments_url)
  #  end
  #
  #end

end
