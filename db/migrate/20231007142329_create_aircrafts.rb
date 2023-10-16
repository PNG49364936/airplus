class CreateAircrafts < ActiveRecord::Migration[6.0]
  def change
    create_table :aircrafts do |t|
      t.string :acft

      t.timestamps
    end
  end
end
