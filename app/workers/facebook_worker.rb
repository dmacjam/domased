require 'koala'

class FacebookWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 1, :queue => :myqueue, :backtrace => true
  
  def init
  	@oauth ||= Koala::Facebook::OAuth.new(CONFIG[:app_id], CONFIG[:app_secret])
  	@token ||= @oauth.get_app_access_token
  	@graph ||= Koala::Facebook::API.new(@token)
  end	
  
  def perform(id)
	init
	event= @graph.get_object(id)
	
    dbEvent = Event.new(name: event["name"],date: event["start_time"],
                        description: event["description"], fb_id_number: event["id"], type_id: 6,
                        :created_at => Time.now, :updated_at => Time.now)
     
    if !event["venue"].nil?
      if !event["venue"]["latitude"].nil?
    	dbEvent.address = "#{event["venue"]["street"]}, #{event["venue"]["city"]}"
    	dbEvent.latitude = event["venue"]["latitude"]
    	dbEvent.longitude = event["venue"]["longitude"]
	  else
	  	dbEvent.address = event["venue"]["name"]
	  end
	end
    
    #puts dbEvent.inspect
    #puts dbEvent.errors.inspect
    
    dbEvent.save
 
  end
end
