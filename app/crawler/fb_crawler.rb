class FbCrawler
      require "koala"

      token="CAACEdEose0cBAFsKSUHkUbWlGRFRWYedZAjEvrRZCBRkPZA5CDMN38d9Kc1ulnkUsZCnOjymQo5GVLXlNnFuTWdnFORjenWyXRBj6kx5lMaFU2ZBatj7FnriFKuHLqfLTj5jSeZBTAHZCqeL6gFtVkqUnD8WQYYfEEJw5NeOUbZA308kzqsafV7YQWBdlvVAOgUZD"
      @graph = Koala::Facebook::API.new(token)
      dopyt='SELECT eid  FROM event_member WHERE uid IN (SELECT page_id FROM place WHERE distance(latitude, longitude, "48.970303", "18.197780") < 50000)'

      pole=@graph.fql_query(dopyt)

      #pole.each do |prvok|
      #  puts prvok["eid"]
      #end

      event=@graph.get_object(pole[0]["eid"])

      puts event["start_time"]
end