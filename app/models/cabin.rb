class Cabin < ApplicationRecord
    validate :unique_cbn
    validates :cbn, length: { within: 1..1 }
    before_validation :upcase_cbn
    has_many :flights
    validates :cbn, presence: true

    validates :cbn, presence: true, format: { with: /\A[A-Z]+\z/,
        message: "doit contenir uniquement des lettres majuscules" }
    
    private

    def unique_cbn
        existing_cbn = Cabin.pluck(:cbn) # Récupère tous les numéros existants dans la base de données
        if existing_cbn.include?(cbn)
          errors.add(:cbn, " : La lettre #{self.cbn} est déjà utilisée.")
        end
    end

    def upcase_cbn
        self.cbn = cbn.upcase if cbn.present?
    end 


   





end
