class AddRegToFlights < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :reg, :string
  end
end
