class FbCrawler
      require "koala"

      token="CAACEdEose0cBAMzlOUA8tiqjjqoyAYYLkb7tKnR04rfbbnRbyLbDbniOFRzWdJE4pQI31CiFgxEadTevABmq4alwRjPvciQ5gn56j1CR0vHxk4fZB7iNduqEoYwy0dXQdZCzZCOil7leiSJdSWj2lmkUE4MwjnqobH8JOVcX8FpvfWHf1mDTi7tGbNIVlAZD"
      @graph = Koala::Facebook::API.new(token)
      dopyt='SELECT eid  FROM event_member WHERE uid IN (SELECT page_id FROM place WHERE distance(latitude, longitude, "48.970303", "18.197780") < 50000)'

      pole=@graph.fql_query(dopyt)

      #pole.each do |prvok|
      #  puts prvok["eid"]
      #end

      event=@graph.get_object(pole[0]["eid"])

      #event2=Event.new(:date => event["name"] )
      #puts event2

      puts event["name"]


      #Daj do lib/tasks s koncovkou .rake a spustas pomocou rake db:nazov...

      #start_lat=47.9
      #end_lat=49.6
      #start_long=16.8
      #end_long=22.5
      #
      #tn_start_long=18.01
      #tn_start_lat=48.8
      #
      ##Slovensko latitude: 47.9-49.6  longitude: 16.8-22.5
      #for i in (tn_start_lat..end_lat).step(0.01) do
      #  for j in (tn_start_long..end_long).step(0.1) do
      #    dopyt="SELECT eid  FROM event_member WHERE uid IN (SELECT page_id FROM place WHERE distance(latitude, longitude, \"#{i}\", \"#{j}\") < 50000)"
      #    pole=@graph.fql_query(dopyt)
      #    if pole.any?
      #      pole.length.times do |cislo|
      #        event=@graph.get_object(pole[cislo]["eid"])
      #        puts "#{j}#{event} "
      #      end
      #    end
      #    #puts '\n'
      #  end
      #end
end