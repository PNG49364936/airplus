class AddHaulToStations < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :haul, :string
  end
end
