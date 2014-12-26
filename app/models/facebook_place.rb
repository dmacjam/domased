class FacebookPlace < ActiveRecord::Base
  validates :place_id, uniqueness: true
end
