require 'koala'

class FacebookWorker
  include Sidekiq::Worker
  
  def init
  	@oauth ||= Koala::Facebook::OAuth.new(CONFIG[:app_id], CONFIG[:app_secret])
  	@token ||= @oauth.get_app_access_token
  	@graph ||= Koala::Facebook::API.new(@token)
  end	
  def perform(id)
	init
	event= @graph.get_object(id)
	
    dbEvent = Event.new(name: event["name"],date: event["start_time"],
                                   latitude: event["venue"]["latitude"], longitude: event["venue"]["longitude"],
                                   description: event["description"], fb_id_number: event["id"], type_id: 6,
                                   :created_at => Time.now, :updated_at => Time.now)
    puts dbEvent.inspect
    puts dbEvent.errors.inspect
    if dbEvent.save(validate: false)
    	puts "#{dbEvent.name} saved"
    end
 
  end
end
