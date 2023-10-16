class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      #fait manuellement.
      t.references :aircraft, foreign_key: true
      t.references :cabin, foreign_key: true
      t.references :registration, foreign_key: true
      t.references :seat, foreign_key: true

     

      t.timestamps




    end
  end
end
