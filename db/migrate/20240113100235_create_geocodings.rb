class CreateGeocodings < ActiveRecord::Migration[6.0]
  def change
    create_table :geocodings do |t|

      t.timestamps
    end
  end
end
