class RenameTownNameToPlaceNameInStations < ActiveRecord::Migration[6.0]
  def change
    rename_column :stations, :town_name, :place_name
  end
end
