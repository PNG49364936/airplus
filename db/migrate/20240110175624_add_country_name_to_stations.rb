class AddCountryNameToStations < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :country_name, :string
  end
end
