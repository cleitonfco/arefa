require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/show.html.erb" do
  include TasksHelper
  
  before(:each) do
    assigns[:task] = @task = stub_model(Task,
      :description => "value for description",
      :done => false,
      :feedback => false,
      :priority => "1"
    )
  end

  it "should render attributes in <p>" do
    render "/tasks/show.html.erb"
    response.should have_text(/value\ for\ description/)
    response.should have_text(/als/)
    response.should have_text(/als/)
    response.should have_text(/1/)
  end
end

