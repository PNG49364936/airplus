class AddArrivalStationToFlights < ActiveRecord::Migration[6.0]
  def change
    add_reference :flights, :arrival_station, foreign_key: { to_table: :stations }
  end
end
