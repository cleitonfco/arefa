require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/edit.html.erb" do
  include TasksHelper
  
  before(:each) do
    assigns[:task] = @task = stub_model(Task,
      :new_record? => false,
      :description => "value for description",
      :done => false,
      :feedback => false,
      :priority => "1",
      :active => true
    )
  end

  it "should render edit form" do
    render "/tasks/edit.html.erb"
    
    response.should have_tag("form[action=#{task_path(@task)}][method=post]") do
      with_tag('input#task_description[name=?]', "task[description]")
      with_tag('input#task_done[name=?]', "task[done]")
      with_tag('input#task_feedback[name=?]', "task[feedback]")
      with_tag('input#task_priority[name=?]', "task[priority]")
      with_tag("input#task_active[name=?]", "task[active]")
    end
  end
end


