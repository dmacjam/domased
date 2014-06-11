require 'spec_helper'

describe "Event pages" do
	subject { page } 

	describe "event presentation page" do
	  let(:event) { FactoryGirl.create(:event) }
	  before { visit event_path(event) }

	  it { should have_content(event.name) }
	end

	describe "add new event form" do
      before { visit new_event_path }
      let(:submit) { "Publish!" }
		
	  describe "with invalid form" do
		it "should not create event" do
		  expect { click_button submit }.not_to change(Event, :count)
		  should have_content('chyb')
		end
	  end

	  describe "with valid form" do
	  	before do
		  fill_in "event_name", with: "Bazant Pohoda"
		  fill_in "event_address", with: "Trencin"
		end
		it "should create event" do
			expect { click_button submit }.to change(Event, :count).by(1)	
			 should have_selector('div.alert.alert-success')
		end
	  end

	end
end
