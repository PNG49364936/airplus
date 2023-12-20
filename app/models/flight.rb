class Flight < ApplicationRecord
    
    belongs_to :registration
    belongs_to :aircraft
    belongs_to :haul
    belongs_to :cabin
    belongs_to :seat
    belongs_to :departure_station, class_name: 'Station', foreign_key: 'departure_station_id'
    belongs_to :arrival_station, class_name: 'Station', foreign_key: 'arrival_station_id'
    belongs_to :airline_code
    validate :unique_station
    validate :check_haul
    validates :registration, :aircraft, :haul, :cabin, :seat, :departure_station, :arrival_station, :airline_code, :flight_number, presence: true
   
  
    
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

   
       

         
end
