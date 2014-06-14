namespace :crawl do
desc "Save Facebook places into redis"
  task :fb_places => :environment do
    require 'koala'
	@oauth = Koala::Facebook::OAuth.new(CONFIG[:app_id], CONFIG[:app_secret])
	@token = @oauth.get_app_access_token
	@graph = Koala::Facebook::API.new(@token)
    
    redis = Redis.new(:host => 'localhost', :port => 6379)

	#diff 0.003
	#BA-lat-48.14 ..  48.18
	#  -lng- 17.05 .. 17.16 
	#ZA 49.19..49.26
	# =>18.64..18.80
	# ZAPAD	48.20 .. 48.74
	# =>17.56..	19.32
	# STRED+VYCHOD 48.72..49.15
	# 			   18.88..22.0

    for i in (48.72..49.15).step(0.03) do
      for j in (18.88..22.0).step(0.003) do
        dopyt="SELECT page_id FROM place WHERE distance(latitude, longitude, \"#{i}\", \"#{j}\") < 50000"
        page_array=@graph.fql_query(dopyt)
        if page_array.any?
          page_array.length.times do |id|
          	#place = FacebookPlace.new(place_id: "#{page_array[id]["page_id"]}")	  
          	#place.save
          	redis.sadd("places","#{page_array[id]["page_id"]}")
          end  
        end
        #sleep 0.5 
      end
    end
 end

desc "Save only places with likes upon boundary"
  task :places_save => :environment do
	require 'koala'
	LIKES_BOUNDARY = 2000
	@oauth = Koala::Facebook::OAuth.new(CONFIG[:app_id], CONFIG[:app_secret])
	@token = @oauth.get_app_access_token
	@graph = Koala::Facebook::API.new(@token)
	redis = Redis.new(:host => 'localhost', :port => 6379)
	
	#FacebookPlace.where(:checked => false).each do |db_place|
	  #place = @graph.get_object(db_place.place_id)
	  #if place["likes"] < LIKES_BOUNDARY	
		#db_place.destroy
	  #else
	  	#db_place.update_attribute(:checked, true)
	  #end
	 #sleep 0.5
	#end
  
    while redis.scard("places") > 0
      id = redis.spop("places")	
	  place = @graph.get_object(id)
	  if place["likes"] > LIKES_BOUNDARY
		FacebookPlace.create(place_id: id, name: place["name"])
	  end
	end 
  end


 desc "Push Ticketportal.sk events into sidekiq" 
  task :ticketportal => :environment do

	(1..50_000).each do |id|
		TicketportalWorker.perform_async(id)	
	end
  end

 desc "Download Slovakia events from Eventbride"
   task :eventbride => :environment do
	require 'open-uri'
	
	url = "https://www.eventbriteapi.com/v3/events/search/?token=HDWIUUQ5MCJJWHZD3TOQ&venue.country=SK&start_date.range_start=#{Time.now.utc.iso8601}"
	result = JSON.parse(open(url).read)
	pages = result["pagination"]["page_count"]
	pocet = 1

	while pocet <= pages
	 url = "https://www.eventbriteapi.com/v3/events/search/?token=HDWIUUQ5MCJJWHZD3TOQ&venue.country=SK&start_date.range_start=#{Time.now.utc.iso8601}&page=#{pocet}"
	 result = JSON.parse(open(url).read)
	  
	  result["events"].each do |event|
	    dbEvent = Event.new
	    dbEvent.name = event["name"]["text"]  
	    dbEvent.description = event["description"]["text"]
	    dbEvent.url_link = event["url"]
	    dbEvent.image = event["logo_url"]
	    dbEvent.date = event["start"]["local"]
	    dbEvent.latitude = event["venue"]["latitude"]
	    dbEvent.longitude = event["venue"]["longitude"]
	    dbEvent.type_id = 0
	    if dbEvent.save
	  	  ReverseGeocodingWorker.perform_async(dbEvent.id)
	    else
	     # LOG puts dbEvent.errors.inspect
	    end
	    pocet = pocet +1
	  end
   end
  end




end

desc "Check all event geocoding record"
  task :check_events => :environment do
	Event.all.each do |event|
		SavingWorker.perform_async(event.id)
		sleep 1
	end
end



