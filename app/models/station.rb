class Station < ApplicationRecord

    before_validation :upcase_name
    before_validation :upcase_place_name
    before_validation :upcase_country_name
    before_validation :upcase_country_name
    before_validation :upcase_haul
    validates :name, length: { within: 3..3 }
    validates :name,presence: true
    validates :place_name,presence: true
    validates :country_name,presence: true
    validates :haul,presence: true
    validate :unique_name
 
    has_many :departure_flights, class_name: 'Flight', foreign_key: 'departure_station_id'
    has_many :arrival_flights, class_name: 'Flight', foreign_key: 'arrival_station_id'
private

def upcase_name
    self.name = name.upcase if name.present?
end

def upcase_place_name
  self.place_name = place_name.upcase if place_name.present?
end

def upcase_country_name
  self.country_name = country_name.upcase if country_name.present?
end

def upcase_haul
  self.haul = haul.upcase if name.present?
end



def unique_name
    existing_name = Station.pluck(:name) # Récupère tous les numéros existants dans la base de données
    pp "test" *100
    if existing_name.include?(name) && name != "CDG"
      errors.add(:name, ":  Le code #{self.name} est déjà utilisé.")
    end
  end





end
