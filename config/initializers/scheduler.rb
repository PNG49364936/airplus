require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new
scheduler.cron'1 00 * * 1-7' do
  puts"delete start"
  Flight.delete_past_flights
end
1.times do
  puts "Salut, les jeunes."
end






