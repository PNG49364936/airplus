class Add < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :departure_place_name, :string
    add_column :flights, :departure_country_name, :string
    add_column :flights, :arrival_place_name, :string
    add_column :flights, :arrival_country_name, :string
  end
end
