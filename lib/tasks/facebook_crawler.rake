namespace :fb do
  desc "Push Facebook events into redis"
	task :push => :environment do
		require 'koala'
			@oauth = Koala::Facebook::OAuth.new(ENV['APP_ID'], ENV['APP_SECRET'])
			@token = @oauth.get_app_access_token
			@graph = Koala::Facebook::API.new(@token)
		    #redis = Redis.new(:host => 'localhost', :port => 6379)

			FacebookPlace.all.each do |place|
			  result = @graph.get_connections(place.place_id,"events")
			  result.each do |event|
		       #FacebookWorker.perform_async(event["eid"])
		       REDIS.rpush("events", event["id"])
		 	  end
			end
			
			#result= @graph.fql_query("SELECT eid, name, start_time, end_time, location, venue, description 
		    #					          FROM event WHERE eid IN ( SELECT eid FROM event_member WHERE uid = 102527254943 )")
		    #result= @graph.fql_query("SELECT eid FROM event_member WHERE uid =410439705735846")
  end

  desc "Save Facebook event from redis"
    task :save => :environment do
      @oauth = Koala::Facebook::OAuth.new(ENV['APP_ID'], ENV['APP_SECRET'])
	  @token = @oauth.get_app_access_token
	  @graph = Koala::Facebook::API.new(@token)
	
	  while REDIS.llen("events") > 0
  	  	event= @graph.get_object(REDIS.lpop("events"))
	  	dbEvent = Event.new(name: event["name"],date: event["start_time"],
                        description: event["description"], fb_id_number: event["id"], type_id: 6,
                        :created_at => Time.now, :updated_at => Time.now)
     
      	if !event["venue"].nil?
        	if !event["venue"]["latitude"].nil?
    	  	  if event["venue"]["street"]
    	  	  	dbEvent.address = "#{event["venue"]["street"]}, #{event["venue"]["city"]}"
			  else
				dbEvent.address = event["venue"]["city"]
			  end
    	      dbEvent.latitude = event["venue"]["latitude"]
    	      dbEvent.longitude = event["venue"]["longitude"]
	    	else
	  	      dbEvent.address = event["venue"]["name"]
	        end
	    end
    
        dbEvent.save
        if dbEvent.new_record?
		  puts "[FB]NOT saved #{dbEvent.errors.inspect}"
		else
          puts "[FB] saved #{dbEvent.name}"
		end
      end
	end
end
