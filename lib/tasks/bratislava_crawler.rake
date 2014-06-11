desc "Stihne eventy v Bratislave z FB stranky"
	task :bratislava_crawl => :environment do
		require 'koala'
			@oauth = Koala::Facebook::OAuth.new(CONFIG[:app_id], CONFIG[:app_secret])
			@token = @oauth.get_app_access_token
			@graph = Koala::Facebook::API.new(@token)
			#result = @graph.get_object("Motionclubsk")
			#result= @graph.fql_query("SELECT eid, name, start_time, end_time, location, venue, description 
		    #					          FROM event WHERE eid IN ( SELECT eid FROM event_member WHERE uid = 102527254943 )")
			
		    #result= @graph.fql_query("SELECT eid FROM event_member WHERE uid = 102527254943")
		    
		    result= @graph.fql_query("SELECT eid FROM event_member WHERE uid =410439705735846")
		    
		    puts result.count
		    
		    result.each do |event|
		     FacebookWorker.perform_async(event["eid"])	
			 puts event["eid"]
			end
end
