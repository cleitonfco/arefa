require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/show.html.erb" do
  include TasksHelper
  
  before(:each) do
    @project = mock_model(Project, :id => "1")
    assigns[:project] = @project
    assigns[:task] = @task = stub_model(Task,
      :description => "value for description",
      :project_id => "1",
      :done => false,
      :feedback => false,
      :priority => "1",
      :active => true
    )
  end

  it "should render attributes in <p>" do
    render "tasks/show.html.erb"
    response.should have_text(/value\ for\ description/)
    response.should have_text(/als/)
    response.should have_text(/als/)
    response.should have_text(/1/)
    response.should have_text(/rue/)
  end
end

