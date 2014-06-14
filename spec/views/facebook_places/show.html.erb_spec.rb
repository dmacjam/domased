require 'spec_helper'

describe "facebook_places/show" do
  before(:each) do
    @facebook_place = assign(:facebook_place, stub_model(FacebookPlace,
      :place_id => "Place",
      :checked => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Place/)
    rendered.should match(/false/)
  end
end
