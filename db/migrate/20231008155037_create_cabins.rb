class CreateCabins < ActiveRecord::Migration[6.0]
  def change
    create_table :cabins do |t|
      t.string :cbn

      t.timestamps
    end
  end
end
