namespace :crawl do
desc "Save Facebook places into redis"
  task :fb_places => :environment do
    require 'koala'
	@oauth = Koala::Facebook::OAuth.new(ENV['APP_ID'], ENV['APP_SECRET'])
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

    for i in (48.55..48.84).step(0.03) do
      for j in (16.80..22.17).step(0.003) do
        dopyt="SELECT page_id FROM place WHERE distance(latitude, longitude, \"#{i}\", \"#{j}\") < 50000"
        page_array=@graph.fql_query(dopyt)
        if page_array.any?
          page_array.length.times do |id|
          	#place = FacebookPlace.new(place_id: "#{page_array[id]["page_id"]}")	  
          	#place.save
          	redis.sadd("places","#{page_array[id]["page_id"]}")
          end  
        end
        sleep 0.5 
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


 desc "Push Ticketportal.sk events into TicketportalWorker" 
  task :ticketportal_push => :environment do

	  (1..50_000).each do |id|
		  url = "http://www.ticketportal.sk/event.aspx?id=#{id}"
		  resp = Net::HTTP.get_response(URI.parse(url))
		  if resp.code.match('200') 
			  html = open(url)
			  doc = Nokogiri::HTML(html)
			  image = doc.search("#ctl00_ContentPlaceHolder1_iNahlad")
			  #puts "--------##{pocet}"

			  #puts "http://www.ticketportal.sk/#{image[0]["src"]}"
			  image = image[0]["src"]
			  element = doc.search("div .podujatie_popis_r p")		#[1]
			  regexp = /e\:\s?(\d{2}\.\d{1,2}\.\d{4})\so.?\s(\d{1,2}\:\d{2})/.match("#{element.text}")
			  return if regexp.nil?
			  date = "#{regexp[1]} #{regexp[2]}"
			  #puts "DATUM - #{date}"
			  title = doc.title.split("|")[0].strip
			  #puts "#{id} - #{doc.title.split("|")[0].strip}"
			  regexp = /t\:((\s[\p{Letter}\-\,\.\(\)[0-9]]+)*)[A-Z]{1}/.match("#{element.text}")
			  return if regexp.nil?
			  city = regexp[1]
			  #puts "MESTO - #{city}"
			  #puts "#{city}"
			  #puts "#{description}"
			  description = element.text	
			  event = Event.create(name: title,description: description,date: date,address: city,url_link: url,image: image, type_id: 7)
		  end
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
	    dbEvent.image = event.try(:[],"logo_url")
	    dbEvent.date = event["start"]["local"]
	    dbEvent.latitude = event.try(:[],"venue").try(:[],"latitude")
	    dbEvent.longitude = event.try(:[],"venue").try(:[],"longitude")
	    city = event.try(:[],"venue").try(:[],"address").try(:[],"city")
	    street = event.try(:[],"venue").try(:[],"address").try(:[],"address_1")
	    dbEvent.address = "#{city}, #{street}"
	    dbEvent.type_id = 0
	    dbEvent.save
	    if dbEvent.errors.any?
	     # LOG puts dbEvent.errors.inspect
	    end
	    pocet= pocet +1 
	  end
   end
  end


end

#desc "Check all event geocoding record"
#  task :check_events => :environment do
#	Event.all.each do |event|
#		SavingWorker.perform_async(event.id)
#		sleep 1
#	end
#end



