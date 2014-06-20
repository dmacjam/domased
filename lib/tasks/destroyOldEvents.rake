desc "Vymaze stare podujatia z databazy"
  task :destroy_old_events => :environment do

    datum = Date.today-1.week
    Event.destroy_all("date < '#{datum}'")

end
