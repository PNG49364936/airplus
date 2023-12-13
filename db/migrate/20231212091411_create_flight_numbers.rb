class CreateFlightNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :flight_numbers do |t|
      t.string :code
      t.integer :number

      t.timestamps
    end
  end
end
