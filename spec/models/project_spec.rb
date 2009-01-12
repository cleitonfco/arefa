require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  def project_attributes(options = {})
    {
      :name => "value for name",
      :description => "value for description",
      :private => true,
      :active => true
    }.merge(options)
  end

  before(:each) do
    @project = Project.new
  end

  it "should create a new instance given valid attributes" do
    Project.create!(project_attributes)
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
    @project.update_attributes(project_attributes).should be_true
  end

  it "should find by id" do
    project = Project.create!(project_attributes)
    Project.find(project.id).should == project
  end

  it "should destroy by id" do
    project = Project.create!(project_attributes)
    lambda {
      Project.destroy(project.id)
    }.should change(Project, :count).by(-1)
  end

  it "should be private on create" do
    project = Project.create!(:name => "value for name")
    project.should be_private
  end

  it "should be active on create" do
    project = Project.create!(:name => "value for name")
    project.should be_active
  end

  it "should be able to activate and deactivate" do
    project = Project.create!(:name => "value for name")
    project.change_active
    project.should_not be_active
    project.change_active
    project.should be_active
  end

end
