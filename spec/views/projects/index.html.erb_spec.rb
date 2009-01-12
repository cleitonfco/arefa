require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/index.html.erb" do
  include ProjectsHelper
  
  before(:each) do
    assigns[:projects] = [
      stub_model(Project,
        :name => "value for name",
        :description => "value for description",
        :private => false,
        :active => true
      ),
      stub_model(Project,
        :name => "value for name",
        :description => "value for description",
        :private => false,
        :active => true
      )
    ]
  end

  it "should render list of projects" do
    render "/projects/index.html.erb"

    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for description", 2)
    response.should have_tag("tr>td", "false", 2)
    response.should have_tag("tr>td", "true", 2)
  end
end

