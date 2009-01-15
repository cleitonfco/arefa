require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
  def comment_attributes(options = {})
    {
      :text => "value for text",
      :task_id => "1"
    }.merge(options)
  end

  before(:each) do
    @comment = Comment.new
  end

  it "should create a new instance given valid attributes" do
    @comment.attributes = comment_attributes
    @comment.save.should be_true
  end

  it "should create a activity on create" do
    comment = Comment.create!(comment_attributes)
    activity = Activity.find_by_comment_id_and_action(comment.id, "add_comment")
    activity.detail.should == "adicionou um comentário à tarefa #{comment.task_id}"
  end

end
