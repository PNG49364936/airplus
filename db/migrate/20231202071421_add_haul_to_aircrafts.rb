class AddHaulToAircrafts < ActiveRecord::Migration[6.0]
  def change
    add_column :aircrafts, :haul, :string
  end
end
