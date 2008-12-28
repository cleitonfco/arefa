require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/index.html.erb" do
  include TasksHelper
  
  before(:each) do
    assigns[:tasks] = [
      stub_model(Task,
        :description => "value for description",
        :project_id => "1",
        :done => false,
        :feedback => false,
        :priority => "1"
      ),
      stub_model(Task,
        :description => "value for description",
        :project_id => "1",
        :done => false,
        :feedback => false,
        :priority => "1"
      )
    ]
  end

  it "should render list of tasks" do
    render "/tasks/index.html.erb"
    response.should have_tag("tr>td", "value for description", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "false", 2)
    response.should have_tag("tr>td", "false", 2)
    response.should have_tag("tr>td", "1", 2)
  end
end

