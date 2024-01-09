class Station < ApplicationRecord

    before_validation :upcase_name
    validates :name, length: { within: 3..3 }
    validates :name,presence: true
    validate :unique_name
 
    has_many :flights, class_name: 'Flight', foreign_key: 'departure_station_id'
    has_many :flights, class_name: 'Flight', foreign_key: 'arrival_station_id'

private

def upcase_name
    self.name = name.upcase if name.present?
end

def unique_name
    existing_name = Station.pluck(:name) # Récupère tous les numéros existants dans la base de données
    pp "test" *100
    if existing_name.include?(name) && name != "CDG"
      errors.add(:name, ":  Le code #{self.name} est déjà utilisé.")
    end
  end





end
