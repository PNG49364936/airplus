class RemoveTownNameFromStations < ActiveRecord::Migration[6.0]
  def change
    remove_column :stations, :town_name, :string
  end
end
