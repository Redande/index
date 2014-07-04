require 'rails_helper'

describe "notes/show.haml" do
  before(:each) do
    @note = assign(:note, stub_model(Note,
      :name => "Name",
      :text => "MyText",
      :user_id => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
