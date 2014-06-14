class ReverseGeocodingWorker
  include Sidekiq::Worker
  
  def perform(id)
	event = Event.find(id)
	result = Geocoder.search("#{event.latitude},#{event.longitude}")
	if result
	  event.update_attribute(:address,result[0].address)
	end
  end

end
