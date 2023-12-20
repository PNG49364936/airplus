class AddAirlineCodeIdToFlights < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :airline_code_id, :integer
  end
end
