require 'open-uri'
require 'nokogiri'

class TicketportalWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 1

  def perform(id)
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
		Event.create(name: title,description: description,date: date,address: city,url_link: url,image: image, type_id: 7)
    end
  end
end
