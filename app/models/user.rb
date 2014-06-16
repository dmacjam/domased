class User < ActiveRecord::Base
  #validates_presence_of :username
  has_many :created_events, :class_name => "Event"  #user.created_events - zobrazi vsetky vytvorene eventy userom

  def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
		  user.provider = auth.provider
		  user.uid = auth.uid
		  user.name = auth.info.name
		  user.oauth_token = auth.credentials.token
		  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		  user.save!
	  end
  end

  def facebook
	@facebook ||= Koala::Facebook::API.new(oauth_token)

  end


end
