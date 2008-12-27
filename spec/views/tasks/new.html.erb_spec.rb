require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/new.html.erb" do
  include TasksHelper
  
  before(:each) do
    assigns[:tasks] = stub_model(Tasks,
      :new_record? => true,
      :text => "value for text",
      :done => false,
      :feedback => false,
      :priority => "1"
    )
  end

  it "should render new form" do
    render "/tasks/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", tasks_path) do
      with_tag("input#tasks_text[name=?]", "tasks[text]")
      with_tag("input#tasks_done[name=?]", "tasks[done]")
      with_tag("input#tasks_feedback[name=?]", "tasks[feedback]")
      with_tag("input#tasks_priority[name=?]", "tasks[priority]")
    end
  end
end


