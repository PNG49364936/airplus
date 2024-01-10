class AirlineCode < ApplicationRecord
    before_validation :upcase_code
    validate :unique_code
    validates :code, length: { within: 2..2 }
    validates :code, presence: true
    has_many :flights, dependent: :destroy




    private

    def unique_code
       existing_code = AirlineCode.pluck(:code) # Récupère tous les numéros existants dans la base de données
       pp "test" *100
       if existing_code.include?(code)
         errors.add(:code, ":  Le code #{self.code} est déjà utilisé.")
       end
     end

     def upcase_code
       self.code = code.upcase if code.present?
     end 




end


