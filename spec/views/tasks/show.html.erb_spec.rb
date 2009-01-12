require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/show.html.erb" do
  include TasksHelper
  
  before(:each) do
    @project = mock_model(Project, :id => "1")
    assigns[:project] = @project
    assigns[:task] = @task = stub_model(Task,
      :description => "value for description",
      :project_id => "1",
      :done => false,
      :feedback => false,
      :priority => "1",
      :active => true
    )
    assigns[:comments] = [ stub_model(Comment,
        :text => "text of comment",
        :task_id => "1"
      )
    ]
    assigns[:comment] = @comment = stub_model(Comment,
      :text => "text of comment",
      :task_id => "1"
    )
  end

  it "should render attributes in <p>" do
    render "tasks/show.html.erb"

    response.should have_text(/value\ for\ description/)
    response.should have_text(/arcar\ como\ [cC]onclu/)
    response.should have_text(/edir\ [fF]eedback/)
    response.should have_text(/normal/)
    response.should have_tag(".comment p", "text of comment")
    response.should have_tag("form[action=?][method=post]", project_task_comment_path(@project, @task, @comment)) do
      with_tag("textarea#comment_text[name=?]", "comment[text]")
    end
  end
end

