require 'spec_helper'

describe "facebook_places/index" do
  before(:each) do
    assign(:facebook_places, [
      stub_model(FacebookPlace,
        :place_id => "Place",
        :checked => false
      ),
      stub_model(FacebookPlace,
        :place_id => "Place",
        :checked => false
      )
    ])
  end

  it "renders a list of facebook_places" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Place".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
