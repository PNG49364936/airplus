class AddHaulIdToStations < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :haul_id, :integer
    add_index :stations, :haul_id 
  end
end
