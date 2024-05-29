class RemoveHaulFromAircrafts < ActiveRecord::Migration[6.0]
  def change
    remove_column :aircrafts, :haul, :string
  end
end
