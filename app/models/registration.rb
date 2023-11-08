class Registration < ApplicationRecord
    before_validation :upcase_reg
    validate :unique_reg
    validate :validate_code_format
   
    has_many :flights
    validates :reg, presence: true
    
   





    private

   

    def upcase_reg
        self.reg = reg.upcase if reg.present?
    end 

    def unique_reg
        existing_reg = Registration.pluck(:reg) # Récupère tous les numéros existants dans la base de données
        pp "test" *100
        if existing_reg.include?(reg)
          errors.add(:reg, ":  L'immat #{self.reg} est déjà utilisé.")
        end
      end

      def validate_code_format
        pp "FORMAT" *100
        # Utilisez une expression régulière pour vérifier le format du code
        unless reg.match?(/\A[a-zA-Z]-[a-zA-Z]{3}\z/)
          errors.add(:reg, " #{self.reg} doit être au format 'A-AAA'")
        end
      end

     


end
