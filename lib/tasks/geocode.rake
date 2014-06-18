namespace :geo do
  desc "Geocode events without coordinates"
  task :without_coordinates => :environment do
		  
	events = Event.not_geocoded
  	events.each do |event|
  	    event.geocode
  	    event.save
  	    #Rails.logger.info("Spracovavam #{result[0].address}")
	  	sleep 1
	end
  
  end

  desc "Geocode events without address"
  task :without_address => :environment do
	Event.where("address IS NULL").each do |event|
		event.reverse_geocode
		event.save
		sleep 1
		#result = Geocoder.search("#{event.latitude},#{event.longitude}")
		#if result
	  	#	event.update_attribute(:address,result[0].address)
	    #end
	end
  end

end
