require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/new.html.erb" do
  include TasksHelper
  
  before(:each) do
    assigns[:task] = stub_model(Task,
      :new_record? => true,
      :description => "value for description",
      :done => false,
      :feedback => false,
      :priority => "1"
    )
  end

  it "should render new form" do
    render "/tasks/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", tasks_path) do
      with_tag("input#task_description[name=?]", "task[description]")
      with_tag("input#task_done[name=?]", "task[done]")
      with_tag("input#task_feedback[name=?]", "task[feedback]")
      with_tag("input#task_priority[name=?]", "task[priority]")
    end
  end
end


