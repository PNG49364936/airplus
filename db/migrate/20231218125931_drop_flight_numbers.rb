class DropFlightNumbers < ActiveRecord::Migration[6.0]
  def change
    drop_table :flight_numbers
  end
end
