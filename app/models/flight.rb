class Flight < ApplicationRecord
    
    belongs_to :registration
    belongs_to :aircraft
    belongs_to :haul
    belongs_to :cabin
    belongs_to :seat
    belongs_to :departure_station, class_name: 'Station', foreign_key: 'departure_station_id'
    belongs_to :arrival_station, class_name: 'Station', foreign_key: 'arrival_station_id'
    validate :unique_station
    private
    def unique_station
        if  arrival_station_id == departure_station_id
            errors.add(:base, "Departure station and Arrival station must be different") 
        end
    end
   
end
