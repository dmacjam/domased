desc "Vymaze stare podujatia z databazy"
  task :destroy_old_events => :environment do

    datum = Date.today
    Event.destroy_all("date < '#{datum}'")

end