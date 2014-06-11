require 'spec_helper'

describe Event do
	#before { @event=Event.create(name: "Summer party", date: Time.now) }
	before { @event=FactoryGirl.create(:event) }
	subject { @event }

	it { should respond_to(:name) }
	it { should respond_to(:date) }
	its(:latitude) { should_not be_blank }
	its(:longitude) { should_not be_blank }

	describe 'when name is not present' do
		before { @event.name="" }
		it { should_not be_valid }
	end

	describe 'when date is not present' do
		before { @event.date=nil }
		it { should_not be_valid }
	end

	describe 'when name is too long' do
		before { @event.name='a'*31 }
		it { should_not be_valid }
	end

	describe 'when it is a duplicate' do
		before do
		  @event_duplicate = @event.dup
		  @event_duplicate.save
		end
		subject { @event_duplicate }
		it { should_not be_valid }
	end
end
