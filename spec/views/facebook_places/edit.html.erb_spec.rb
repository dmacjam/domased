require 'spec_helper'

describe "facebook_places/edit" do
  before(:each) do
    @facebook_place = assign(:facebook_place, stub_model(FacebookPlace,
      :place_id => "MyString",
      :checked => false
    ))
  end

  it "renders the edit facebook_place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", facebook_place_path(@facebook_place), "post" do
      assert_select "input#facebook_place_place_id[name=?]", "facebook_place[place_id]"
      assert_select "input#facebook_place_checked[name=?]", "facebook_place[checked]"
    end
  end
end
