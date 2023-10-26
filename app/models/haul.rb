class Haul < ApplicationRecord
    validates :name, length: { within: 2..2, message: "doit contenir 2 lettres maxi"}
    before_validation :upcase_name
    validate :unique_name
    validates :name, presence: true, format: { with: /\A[A-Z]{2}\z/,
    message: "doit contenir uniquement 2 lettres majuscules" }
    validates :name, format: { with: /\A[A-Z]H\z/, message: "doit contenir une lettre suivie de 'H'" }
    
    

private

def upcase_name
    self.name = name.upcase if name.present?
end 

def unique_name
    existing_name = Haul.pluck(:name) # Récupère tous les numéros existants dans la base de données
    if existing_name.include?(name)
      errors.add(:name, " : Le code #{self.name} est déjà utilisée.")
    end
end





end
