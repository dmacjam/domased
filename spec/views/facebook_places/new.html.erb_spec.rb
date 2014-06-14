require 'spec_helper'

describe "facebook_places/new" do
  before(:each) do
    assign(:facebook_place, stub_model(FacebookPlace,
      :place_id => "MyString",
      :checked => false
    ).as_new_record)
  end

  it "renders new facebook_place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", facebook_places_path, "post" do
      assert_select "input#facebook_place_place_id[name=?]", "facebook_place[place_id]"
      assert_select "input#facebook_place_checked[name=?]", "facebook_place[checked]"
    end
  end
end
