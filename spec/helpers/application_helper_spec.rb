require 'spec_helper'

describe ApplicationHelper do
	
	describe 'full title' do
		it 'should iclude domain name' do
			expect(full_title("fiit")).to match(/Domased/)
		end

		it 'should include the subpage title' do
			expect(full_title("fiit")).to match(/fiit/)
		end
	end
end
