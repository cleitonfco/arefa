require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TasksController do
  describe "route generation" do
    it "should map #new" do
      route_for(:controller => "tasks", :action => "new", :project_id => "1").should == "/projects/1/tasks/new"
    end

    it "should map #show" do
      route_for(:controller => "tasks", :action => "show", :id => 1, :project_id => "1").should == "/projects/1/tasks/1"
    end

    it "should map #edit" do
      route_for(:controller => "tasks", :action => "edit", :id => 1, :project_id => "1").should == "/projects/1/tasks/1/edit"
    end

    it "should map #update" do
      route_for(:controller => "tasks", :action => "update", :id => 1, :project_id => "1").should == "/projects/1/tasks/1"
    end

    it "should map #destroy" do
      route_for(:controller => "tasks", :action => "destroy", :id => 1, :project_id => "1").should == "/projects/1/tasks/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #new" do
      params_from(:get, "/projects/1/tasks/new").should == {:controller => "tasks", :action => "new", :project_id => "1"}
    end

    it "should generate params for #create" do
      params_from(:post, "/projects/1/tasks").should == {:controller => "tasks", :action => "create", :project_id => "1"}
    end

    it "should generate params for #show" do
      params_from(:get, "/projects/1/tasks/1").should == {:controller => "tasks", :action => "show", :id => "1", :project_id => "1"}
    end

    it "should generate params for #edit" do
      params_from(:get, "/projects/1/tasks/1/edit").should == {:controller => "tasks", :action => "edit", :id => "1", :project_id => "1"}
    end

    it "should generate params for #update" do
      params_from(:put, "/projects/1/tasks/1").should == {:controller => "tasks", :action => "update", :id => "1", :project_id => "1"}
    end

    it "should generate params for #destroy" do
      params_from(:delete, "/projects/1/tasks/1").should == {:controller => "tasks", :action => "destroy", :id => "1", :project_id => "1"}
    end
  end
end
