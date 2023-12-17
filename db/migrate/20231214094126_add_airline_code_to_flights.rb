class AddAirlineCodeToFlights < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :airline_code, :string
  end
end
