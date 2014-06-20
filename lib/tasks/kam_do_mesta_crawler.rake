namespace :kam_do_mesta do
  desc "Push events from categories into redis"
  task :push => :environment do
	require 'open-uri'
	site = "http://www.kamdomesta.sk/" 
	urls = ["koncerty","festivaly","party2","predstavenia","vystavy","hudba-a-tanec","prednasky","workshopy","kurzy","deti-a-mladez",
			"sport","ine"]
	
	urls.each do |url|
	  html = open("#{site}#{url}")
	  index_doc = Nokogiri::HTML(html)
	
	  index_doc.search('.event-short-title').each do |title|
	    link = title.search('a').first["href"]
	    REDIS.rpush("kam_do_mesta",link)
	  end
    end

  end
  
  desc "Save events from redis"
  task :save => :environment do
	require 'open-uri'

	while REDIS.llen("kam_do_mesta") > 0
		link= REDIS.lpop("kam_do_mesta")
		event = Event.new
    	event.url_link = "http://www.kamdomesta.sk#{link}"
    	html = open(event.url_link)
		doc = Nokogiri::HTML(html)
	
	  
		event_block = doc.search("div #event")
		main_info_block = event_block.search(".eventMainInfoBlock")
		time_block = main_info_block.search(".timeInfo").search("span")
	
		event.image = event_block.search(".eventImageBlock").try(:[],0).search("a").first["href"]
		event.name = main_info_block.search("h1").try(:[],0).try(:text)
		type = main_info_block.search(".event-type").try(:[],0).try(:text)
		case type
	  		when "Koncert","Festival" then event.type_id = 2
	  		when "Párty" then event.type_id = 1
	  		when "Film" then event.type_id = 4
	  		when "Predstavenie" then event.type_id = 3
	  		when "Výstava","Prehliadka","Vystúpenie" then event.type_id = 9
	  		when "Udalosť" then event.type_id = 0
	  		when "Workshop","Kurz","Prezentácia","Prednáška","Diskusia" then event.type_id = 5
	  		when "Šport" then event.type_id = 8
	  		when "Pre deti" then event.type_id = 10
	  		else event.type_id = 0
		end

		event.address = main_info_block.search(".placeInfo").try(:[],0).try(:text)
		date = time_block.try(:[],0).try(:text)
		time = /\d{2}\:\d{2}/.match(time_block.try(:[],1).try(:text))
		event.date = "#{date} #{time}"  
		event.description = event_block.search(".section").try(:[],0).try(:text)
  		if event.save
  			puts "[KdM]#{event.name} saved"
		end
	end

  end


end
