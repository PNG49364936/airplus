class AddAirportNameToStations < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :airport_name, :string
  end
end
