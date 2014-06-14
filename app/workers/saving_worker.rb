class SavingWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 2, :backtrace => true
   
  sidekiq_retries_exhausted do |msg|
      Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  def perform(id)
  	event = Event.find(id)
  	result = Geocoder.search(event.address)
  	if result
		event.update_attribute(:latitude,result[0].coordinates[0])
		event.update_attribute(:longitude,result[0].coordinates[1])
		event.update_attribute(:address,result[0].address)
		#Rails.logger.info("Spracovavam #{result[0].address}")
	end
  end
end
