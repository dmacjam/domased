class FacebookPlace < ActiveRecord::Base
  validate :place_id, uniqueness: true
end
