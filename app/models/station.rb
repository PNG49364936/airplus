class Station < ApplicationRecord

    before_validation :upcase_name
    validates :name, length: { within: 3..3 }
    validates :name,presence: true
    validate :unique_name

private

def upcase_name
    self.name = name.upcase if name.present?
end

def unique_name
    existing_name = Station.pluck(:name) # Récupère tous les numéros existants dans la base de données
    pp "test" *100
    if existing_name.include?(name)
      errors.add(:name, ":  Le code #{self.name} est déjà utilisé.")
    end
  end





end
