class RenameAirportNameToTownNameInStations < ActiveRecord::Migration[6.0]
  def change
    rename_column :stations, :airport_name, :town_name
  end
end
