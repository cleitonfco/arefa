require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/activities/index.html.erb" do
  include ActivitiesHelper
  
  before(:each) do
    assigns[:activities] = [
      stub_model(Activity,
        :responsible_user => "1",
        :detail => "value for detail",
        :action => "value for action",
        :time => Time.now
      ),
      stub_model(Activity,
        :responsible_user => "1",
        :detail => "value for detail",
        :action => "value for action",
        :time => Time.now
      )
    ]
  end

  it "should render list of activities" do
    render "/activities/index.html.erb"
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "value for detail", 2)
    response.should have_tag("tr>td", "value for action", 2)
  end
end

