class AddDepartureStationToFlights < ActiveRecord::Migration[6.0]
  def change
    add_reference :flights, :departure_station, foreign_key: { to_table: :stations }
  end
end
