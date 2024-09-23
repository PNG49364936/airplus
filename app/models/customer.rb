class Customer < ApplicationRecord
    before_validation :upcase_name
    before_validation :upcase_first_name

    has_many :bookings
    has_many :flights, through: :bookings




private
  def upcase_name
    self.name = name.upcase if name.present?
  end 


  def upcase_first_name
    self.first_name = first_name.capitalize if first_name.present?
  end 


end
