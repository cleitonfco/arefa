require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController do
  describe "route generation" do
    #it "should map #destroy" do
    #  route_for(:controller => "comments", :action => "destroy", :id => 1).should == "/comments/1"
    #end
  end

  describe "route recognition" do
    it "should generate params for #create" do
      params_from(:post, "/projects/1/tasks/1/comments").should == {:controller => "comments", :action => "create", :project_id => "1", :task_id => "1"}
    end
  
    #it "should generate params for #destroy" do
    #  params_from(:delete, "/comments/1").should_not == {:controller => "comments", :action => "destroy", :id => "1"}
    #end
  end
end
