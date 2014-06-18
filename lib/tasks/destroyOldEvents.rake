desc "Vymaze stare podujatia z databazy"
  task :destroy_old_events => :environment do

    datum = Date.today-2.weeks
    Event.destroy_all("date < '#{datum}'")

end
