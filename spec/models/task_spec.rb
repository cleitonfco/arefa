require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Task do
  before(:each) do
    @valid_attributes = {
      :text => "value for text",
      :project_id => "1",
      :done => false,
      :feedback => false,
      :priority => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    Task.create!(@valid_attributes)
  end

  it "should valid presence of text" do
    task = Task.new
    task.should_not be_valid
    task.errors.on(:text).should == "O Texto não pode ser vazio."
  end

  it "should valid presence of project" do
    task = Task.new
    task.should_not be_valid
    task.errors.on(:project_id).should == "O Projeto não pode ser vazio."
  end

  it "should valid presence of done" do
    task = Task.new
    task.should_not be_valid
    task.errors.on(:done).should == "A Conclusão da Tarefa não pode ser vazia (verdadeiro/falso)."
  end

  it "should valid presence of feedback" do
    task = Task.new
    task.should_not be_valid
    task.errors.on(:feedback).should == "O Feedback da Tarefa não pode ser vazio (verdadeiro/falso)."
  end

  it "should valid presence of priority" do
    task = Task.new
    task.should_not be_valid
    task.errors.on(:priority).should_have "A prioridade não pode ser vazia."
  end

  it "should valid range of priority" do
    task = Task.new
    task.should_not be_valid
    task.errors.on(:priority).should == "A prioridade deve ser um valor entre 1 e 3."
  end

end
