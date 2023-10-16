class Aircraft < ApplicationRecord
 
    before_validation :upcase_acft
    validate :unique_acft
    validates :acft, length: { within: 4..4 }
    validates :acft, presence: true
    validates :acft, format: { with: /\A[a-zA-Z][0-9]+\z/,
    message:   "doit commencer par une lettre et être suivi de 3 chiffres" }
#_________________________________________________________________________________
   private

     def unique_acft
        existing_acft = Aircraft.pluck(:acft) # Récupère tous les numéros existants dans la base de données
        pp "test" *100
        if existing_acft.include?(acft)
          errors.add(:acft, ":  Le code #{self.acft} est déjà utilisé.")
        end
      end

      def upcase_acft
        self.acft = acft.upcase if acft.present?
      end 
end
