class AddHaulToFlights < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :haul, :string
    add_reference :flights, :haul, foreign_key: true
  end
end
