# app/models/flight.rb
class Flight < ApplicationRecord
  has_many :bookings
  has_many :customers, through: :bookings
end

# app/models/customer.rb
class Customer < ApplicationRecord
  has_many :bookings
  has_many :flights, through: :bookings
end

# app/models/booking.rb
class Booking < ApplicationRecord
  belongs_to :flight
  belongs_to :customer
end
