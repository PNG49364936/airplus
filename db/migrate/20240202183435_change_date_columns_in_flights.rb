class ChangeDateColumnsInFlights < ActiveRecord::Migration[6.0]
  def change
    change_column :flights, :departure_date, :date
    change_column :flights, :arrival_date, :date
  end
end
