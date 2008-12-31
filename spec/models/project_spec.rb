require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :private => true,
      :active => true
    }
    @project = Project.new
    @valid_project = Project.create!(@valid_attributes)
    @basic_project = Project.create!({:name => "value for name"})
  end

  it "should create a new instance given valid attributes" do
    @valid_project
  end

  it "should valid presence of name" do
    @project.should_not be_valid
    @project.should have(1).error_on(:name)
  end

  it "should validate when saving" do
    @project.save.should be_false
  end

  it "should validate when updating attributes" do
    @project.update_attributes({}).should be_false
    @project.update_attributes(@valid_attributes).should be_true
  end

  it "should find by id" do
    Project.find(@valid_project.id).should == @valid_project
  end

  it "should destroy by id" do
    lambda {
      Project.destroy(@valid_project.id)
    }.should change(Project, :count).by(-1)
  end

  it "should be private on create" do
    @basic_project.should be_private
  end

  it "should be active on create" do
    @basic_project.should be_active
  end

  it "should be able to activate and deactivate" do
    @basic_project.change_active
    @basic_project.should_not be_active
    @basic_project.change_active
    @basic_project.should be_active
  end

end
