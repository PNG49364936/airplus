class AddIsReturnFlightToFlights < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :is_return_flight, :boolean, default: false
  end
end
