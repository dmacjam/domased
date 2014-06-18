# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :output, "#{path}/log/cron.log"


every 1.day, :at => '3:30 am' do
  rake "kam_do_mesta:push"
end

every :day, :at => '3:50 am' do
  rake "kam_do_mesta:save"
end

every :day, :at => '2:00 am' do
  rake "crawl:ticketportal_push"
end

every :day, :at => '1:00 am' do
  rake "crawl:eventbride"
end

every :day, :at => '4:10 am' do
  rake "fb:push"
end  
  
every :day, :at => '4:40 am' do
  rake "fb:save"
end

every :day, :at => '0:50 am' do
  rake "destroy_old_events"
end
