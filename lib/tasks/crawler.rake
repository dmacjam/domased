desc "Download Facebook events"
  task :fb => :environment do
    require 'koala'
    token="CAACEdEose0cBAJPNdbK6zV1pTwOuvtdvre8sLOgl4RBiSDxrdeHSbhGwYJzYjinsdj2qC2ZAZBgvuh2SwLQGiYocezo7aUFlRphhsSSXNPnb3jUnnd6aAgnCaY5IoceIbPSb2TWg3VWS3lchRbToOl1W7Llv3CwaeMWm5APBu0jFZAmw7NIMQfGBjlP5tYZD"
    @graph = Koala::Facebook::API.new(token)

    tn_start_long=17.95
    #tn_start_lat=48.8


    end_lat=49.15
    end_long=18.45

    pocet=0

    puts "Starting crawler"

    for i in (48.14..48.18).step(0.003) do
      for j in (17.05..17.16).step(0.003) do
        dopyt="SELECT eid  FROM event_member WHERE uid IN (SELECT page_id FROM place WHERE distance(latitude, longitude, \"#{i}\", \"#{j}\") < 50000)"
        pole=@graph.fql_query(dopyt)
        if pole.any?
          pole.length.times do |cislo|
            event=@graph.get_object(pole[cislo]["eid"])

            if event["start_time"] > Time.now

            dbEvent = Event.new(:name => event["name"],:date => event["start_time"],
                                   :latitude => event["venue"]["latitude"], :longitude => event["venue"]["longitude"],
                                   :description => event["description"], :fb_id_number => event["id"], :type_id => 6,
                                   :created_at => Time.now, :updated_at => Time.now)


            if dbEvent.save
              puts "#{dbEvent.name} saved"
              pocet=pocet+1
            #else
              #puts "#{dbEvent.name} exist"
            end

            end
          end
        end
        #puts "Longitude: #{j}"
      end
      puts "Latitude: #{i}"
    end


    puts "Pridanych #{pocet} podujati"
 end

desc "Download Ticketportal.sk events" 
  task :ticketportal_crawl => :environment do
  	require 'nokogiri'
  	require 'open-uri'

	(1..40_000).each do |id|
	  url = "http://www.ticketportal.sk/event.aspx?id=#{id}"
	  resp = Net::HTTP.get_response(URI.parse(url))
 	  if resp.code.match('200') 
        html = open(url)
        doc = Nokogiri::HTML(html)
        
        doc.search("div .podujatie_popis_r")
        puts "#{id} - #{doc.title.split("|")[0].strip}"
	  end
	end
  end

