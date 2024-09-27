class Customer < ApplicationRecord
  has_many :bookings, dependent: :nullify
  has_many :flights, through: :bookings

  before_validation :upcase_name
  before_validation :capitalize_first_name

  scope :active, -> { where(deleted_at: nil) }

  def soft_delete
    update(deleted_at: Time.current)
  end

  def deleted?
    deleted_at.present?
  end

  private

  def upcase_name
    self.name = name.upcase if name.present?
  end 

  def capitalize_first_name
    self.first_name = first_name.capitalize if first_name.present?
  end 
end