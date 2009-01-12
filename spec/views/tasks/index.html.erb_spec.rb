require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/index.html.erb" do
  include TasksHelper
  
  before(:each) do
    @project = mock_model(Project, :id => "1")
    @project.stub!(:name).and_return("project name")
    assigns[:project] = @project
    assigns[:tasks] = [
      stub_model(Task,
        :description => "value for description",
        :project_id => "1",
        :done => false,
        :feedback => false,
        :priority => "1",
        :active => true
      ),
      stub_model(Task,
        :description => "value for description",
        :project_id => "1",
        :done => false,
        :feedback => false,
        :priority => "1",
        :active => true
      )
    ]
  end

  it "should render list of tasks" do
    render "/tasks/index.html.erb"

    response.should have_tag("h2", "project name")
    response.should have_tag("ul>li", "value for description - Excluir")
    response.should have_tag("p a", "Adicionar nova tarefa")
  end
end

