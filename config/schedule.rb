every 1.day, at: '00:01 am' do
  runner "Flight.delete_past_flights"
end
  