require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/layouts/general" do

  it "should yield" do
    render "/../../spec/resources/views/layout_example.html.erb", :layout => "general"
    response.should have_tag('div#content', 'yielded from layout')
  end

  it "should have title" do
    render "/../../spec/resources/views/layout_example.html.erb", :layout => "general"
    response.should have_tag("h1", "Arefa")
  end

end
