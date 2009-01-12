require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/activities/show.html.erb" do
  include ActivitiesHelper
  
  before(:each) do
    assigns[:activity] = @activity = stub_model(Activity,
      :responsible_user => "1",
      :detail => "value for detail",
      :action => "value for action",
      :time => Time.now
    )
  end

  it "should render attributes in <p>" do
    render "/activities/show.html.erb"
    response.should have_text(/1/)
    response.should have_text(/value\ for\ detail/)
    response.should have_text(/value\ for\ action/)
  end
end

