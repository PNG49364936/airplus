class AddTownNameToStations < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :town_name, :string
  end
end
