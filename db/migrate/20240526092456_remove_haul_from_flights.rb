class RemoveHaulFromFlights < ActiveRecord::Migration[6.0]
  def change
    remove_column :flights, :haul, :string
  end
end
