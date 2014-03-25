require 'spec_helper'

describe "links/index" do
  before(:each) do
    assign(:links, [
      stub_model(Link,
        :title => "Title",
        :url => "Url",
        :description => "MyText",
        :source => "Source",
        :user_id => 1,
        :domain_id => "Domain"
      ),
      stub_model(Link,
        :title => "Title",
        :url => "Url",
        :description => "MyText",
        :source => "Source",
        :user_id => 1,
        :domain_id => "Domain"
      )
    ])
  end

  it "renders a list of links" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Domain".to_s, :count => 2
  end
end
