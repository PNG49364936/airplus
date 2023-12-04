class AddHaulIdToAircrafts < ActiveRecord::Migration[6.0]
  def change
    add_column :aircrafts, :haul_id, :integer
  end
end
