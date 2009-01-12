require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/activities/edit.html.erb" do
  include ActivitiesHelper
  
  before(:each) do
    assigns[:activity] = @activity = stub_model(Activity,
      :new_record? => false,
      :responsible_user => "1",
      :detail => "value for detail",
      :action => "value for action",
      :time => Time.now
    )
  end

  it "should render edit form" do
    render "/activities/edit.html.erb"
    
    response.should have_tag("form[action=#{activity_path(@activity)}][method=post]") do
      with_tag('input#activity_responsible_user[name=?]', "activity[responsible_user]")
      with_tag('input#activity_detail[name=?]', "activity[detail]")
      with_tag('input#activity_action[name=?]', "activity[action]")
    end
  end
end


