require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/activities/new.html.erb" do
  include ActivitiesHelper
  
  before(:each) do
    assigns[:activity] = stub_model(Activity,
      :new_record? => true,
      :responsible_user => "1",
      :detail => "value for detail",
      :action => "value for action",
      :time => Time.now
    )
  end

  it "should render new form" do
    render "/activities/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", activities_path) do
      with_tag("input#activity_responsible_user[name=?]", "activity[responsible_user]")
      with_tag("input#activity_detail[name=?]", "activity[detail]")
      with_tag("input#activity_action[name=?]", "activity[action]")
    end
  end
end


