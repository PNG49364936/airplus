class Seat < ApplicationRecord

validate :unique_number
validates :number, numericality: { greater_than: 99, less_than: 451 }
has_many :flights
validates :number, presence: true




private

def unique_number
    existing_number = Seat.pluck(:number) # Récupère tous les numéros existants dans la base de données
    pp "test" *100
    if existing_number.include?(number)
      errors.add(:number, ":  Ce nombre #{self.number} est déjà renseigné.")
    end
  end

end
