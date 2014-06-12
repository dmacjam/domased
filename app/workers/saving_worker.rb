class SavingWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 2, :backtrace => true
  
  def perform(id)
  	event = Event.find(id)
  	#event.check
  	result = Geocoder.search(event.address)
  	if result
		event.update_attribute(:latitude,result[0].coordinates[0])
		event.update_attribute(:longitude,result[0].coordinates[1])
		event.update_attribute(:address,result[0].address)
		#Rails.logger.info("Spracovavam #{result[0].address}")
	end
  end
end