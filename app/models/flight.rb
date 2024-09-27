class Flight < ApplicationRecord
    attr_accessor :date_range
    #attr_accessor :is_return_flight
    
    belongs_to :registration
    belongs_to :aircraft
    belongs_to :haul
    belongs_to :cabin
    belongs_to :seat
    belongs_to :airline_code
    validate :unique_station
    validate :check_haul
    validate :check_haul_registration
    validates :registration, :aircraft, :haul, :cabin, :seat, :departure_station, :arrival_station, :airline_code, :flight_number, presence: true
    validate :unique_flight_number_for_airline, unless: -> { is_return_flight }
    validate :validate_flight_number_length
    validate :validate_flight_number_odd_even
    validates :departure_date, :arrival_date, presence: true
    validate :arrival_after_departure
    #belongs_to :departure_station, class_name: 'Station', optional: true
    #belongs_to :arrival_station, class_name: 'Station', optional: true
    belongs_to :departure_station, class_name: 'Station', foreign_key: 'departure_station_id', optional: true
    belongs_to :arrival_station, class_name: 'Station', foreign_key: 'arrival_station_id', optional: true
    
    belongs_to :departure_station, class_name: 'Station', foreign_key: 'departure_station_id'
    belongs_to :arrival_station, class_name: 'Station', foreign_key: 'arrival_station_id'
  
    before_validation :set_station_details
    validate :registration_uniqueness_per_day, unless: :allow_duplicate_registration?
 
    has_many :bookings, dependent: :nullify
    has_many :customers, through: :bookings
   #validate :allow_duplicate_registration?
   
    
    def has_return_flight?
      Flight.where(flight_number: self.flight_number + 1, departure_station_id: self.arrival_station_id, arrival_station_id: self.departure_station_id).exists?
    end

    def self.delete_past_flights
      pp "delete" * 15
      Rails.logger.info "Starting to delete past flights at #{Time.now}"
      where("departure_date < ?", Date.today).destroy_all
      Rails.logger.info "Finished deleting past flights at #{Time.now}"
    end
    def self.print
      puts"test scgeduler"
    end

    private

    




    def unique_station
        if  arrival_station_id == departure_station_id
            errors.add(:base, "Departure station and Arrival station must be different, please update") 
        end
    end

    def check_haul
        # Obtenez le haul de l'avion
        return unless aircraft.present?
        # Normalisez la casse pour la comparaison
        pp "aircraft"*10
       
        aircraft_haul = aircraft.haul.name
        pp "self" * 10
        pp self.haul
        flight_haul = self.haul
        # Vérifiez si les conditions spécifiées sont remplies
        # Normalisez la casse pour la comparaison
        
        # Vérifiez si les conditions spécifiées sont remplies
        if aircraft.haul == "MH" && flight.haul != "MH"
          
         
            errors.add(:base, "Attention: Un avion avec un réseau de haul 'MH' ne peut effectuer des vols LH'.")
          elsif aircraft.haul == "LH" && (flight_haul != "LH" && flight_haul != "MH")
            errors.add(:base, "Attention: Un avion avec un réseau de haul 'LH' ne peut effectuer que des vols de type 'LH' ou 'MH'.")
        end
      end


      def check_haul_registration
        return unless aircraft.present?
        registration_haul = registration.haul
        pp "1"* 20
        pp registration_haul
        flight_haul = self.haul.name
        pp "2"* 20
        pp flight_haul
        if registration_haul == "MH" && flight_haul!= "MH"
         
          errors.add(:base, "Attention: Un avion avec une registration de haul 'MH' ne peut effectuer des vols LH'.")
        elsif registration_haul == "LH" && (flight_haul != "LH" && flight_haul != "MH")
          errors.add(:base, "Attention: Un avion avec un registration de haul 'LH' ne peut effectuer que des vols de type 'LH' ou 'MH'.")
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

      def self.create_return_flight(flight)
        new_flight = flight.dup # Duplique l'objet flight pour créer un nouveau vol avec des attributs identiques
        # Inverser les stations de départ et d'arrivée
        new_flight.departure_station_id = flight.arrival_station_id
        new_flight.arrival_station_id = flight.departure_station_id
    
        # Ajuster la date de départ et d'arrivée pour le vol retour
        # Cette logique dépend de la façon dont vous souhaitez calculer ces dates
        #new_flight.departure_date = flight.arrival_date + 1.day
        #new_flight.arrival_date = new_flight.departure_date + (flight.arrival_date - flight.departure_date)
    
        # Ajuster le numéro de vol si nécessaire
        # Cette logique dépend de vos règles métier pour la numérotation des vols retour
        new_flight.flight_number = adjust_flight_number(flight.flight_number)
        new_flight.is_return_flight = true
        new_flight.save # Sauvegarde le nouveau vol dans la base de données
        new_flight # Retourne le nouvel objet vol
      end
    
      # Exemple de méthode pour ajuster le numéro de vol
      # Vous devrez implémenter cette logique en fonction de vos besoins
      def self.adjust_flight_number(flight_number)
        # Exemple : si le numéro de vol est pair, ajoute +1 pour le rendre impair (ou vice versa)
        flight_number.even? ? flight_number + 1 : flight_number - 1
      end

      def set_station_details
        if departure_station_id && arrival_station_id
          departure_station = Station.find(departure_station_id)
          arrival_station = Station.find(arrival_station_id)
    
          self.departure_place_name = departure_station.place_name
          self.departure_country_name = departure_station.country_name
          self.arrival_place_name = arrival_station.place_name
          self.arrival_country_name = arrival_station.country_name
        end
      end


      #NEW POINTERS
      def set_coordinates
        return if latitude.present? && longitude.present?
    
        coordinates = geocode_place("#{place_name}, #{country_name}")
        if coordinates
          self.latitude = coordinates[1]
          self.longitude = coordinates[0]
        end
      end

      def registration_uniqueness_per_day
        existing = Flight.where(registration_id: registration_id, departure_date: departure_date)
                         .where.not(id: id)
        pp existing
        if existing.any?
          pp "test1" * 10
          pp is_return_flight
          if is_return_flight?
           
            pp "test2" * 10
            # Pour les vols retour, assurez-vous qu'il n'y a pas d'autres vols retour avec la même registration ce jour-là.
            if existing.where(is_return_flight: true).exists?
              errors.add(:registration_id, "est déjà utilisé pour un autre vol retour à cette date")
            end
          else
            # Pour les vols non-retour, empêchez l'utilisation de la même registration le même jour.
            errors.add(:registration_id, "est déjà utilisé pour un autre vol à cette date")
          end
        end
      end

      def allow_duplicate_registration?
        # Votre logique ici, par exemple :
        is_return_flight? && Flight.where(registration_id: registration_id, departure_date: departure_date, is_return_flight: false).exists?
      end
       
     
      
end
