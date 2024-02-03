class AddEndDtateToFlights < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :end_date, :datetime
  end
end
