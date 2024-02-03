class Flight < ApplicationRecord
    attr_accessor :date_range
    
    belongs_to :registration
    belongs_to :aircraft
    belongs_to :haul
    belongs_to :cabin
    belongs_to :seat
    belongs_to :airline_code
    validate :unique_station
    validate :check_haul
    validates :registration, :aircraft, :haul, :cabin, :seat, :departure_station, :arrival_station, :airline_code, :flight_number, presence: true
    validate :unique_flight_number_for_airline
    validate :validate_flight_number_length
    validate :validate_flight_number_odd_even
    validates :departure_date, :arrival_date, presence: true
    validate :arrival_after_departure
    #belongs_to :departure_station, class_name: 'Station', optional: true
    #belongs_to :arrival_station, class_name: 'Station', optional: true
    belongs_to :departure_station, class_name: 'Station', foreign_key: 'departure_station_id', optional: true
    belongs_to :arrival_station, class_name: 'Station', foreign_key: 'arrival_station_id', optional: true
    
    private
    def unique_station
        if  arrival_station_id == departure_station_id
            errors.add(:base, "Departure station and Arrival station must be different, please update") 
        end
    end

    def check_haul
        return unless aircraft.present?

        # Obtenez le haul de l'avion
        return unless aircraft.present?

        # Normalisez la casse pour la comparaison
        aircraft_haul = aircraft.haul
        flight_haul = self.haul

        # Vérifiez si les conditions spécifiées sont remplies
        # Normalisez la casse pour la comparaison
        aircraft_haul_upcase = aircraft.haul.upcase
        flight_haul_upcase = self.haul.name.upcase

        # Vérifiez si les conditions spécifiées sont remplies
        if aircraft_haul_upcase == "MH" && flight_haul_upcase != "MH"
            errors.add(:base, "Attention: Un avion avec un réseau de haul 'MH' ne peut effectuer des vols LH'.")
          elsif aircraft_haul_upcase == "LH" && (flight_haul_upcase != "LH" && flight_haul_upcase != "MH")
            errors.add(:base, "Attention: Un avion avec un réseau de haul 'LH' ne peut effectuer que des vols de type 'LH' ou 'MH'.")
    end
       end

       def unique_flight_number_for_airline
            if Flight.exists?(airline_code_id: airline_code_id, flight_number: flight_number)
            errors.add(:flight_number, "has already been taken for this airline code")
            end
       end

       def validate_flight_number_length
            return unless flight_number.present?
        
            flight_number_str = flight_number.to_s
            if haul.name == 'LH' && flight_number_str.length != 3
            errors.add(:flight_number, 'must be 3 digits for LH haul')
            elsif haul.name != 'LH' && flight_number_str.length != 4
            errors.add(:flight_number, 'must be 4 digits for other hauls')
            end
        end

       def validate_flight_number_odd_even 
            if departure_station.name == "CDG" && flight_number.odd?
                errors.add(:flight_number," must be even")
                elsif arrival_station.name == "CDG" && flight_number.even?
                    errors.add(:flight_number,"must be odd")
            end
       end

       def arrival_after_departure
        return if departure_date.blank? || arrival_date.blank?
    
        if arrival_date < departure_date
          errors.add(:arrival_date, "must be after the departure date")
        end
      end

   
       

         
end
