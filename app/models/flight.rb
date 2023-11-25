class Flight < ApplicationRecord
    
    belongs_to :registration
    belongs_to :aircraft
    belongs_to :haul
    belongs_to :cabin
    belongs_to :seat
    belongs_to :departure_station, class_name: 'Station', foreign_key: 'departure_station_id'

    private
   
end
