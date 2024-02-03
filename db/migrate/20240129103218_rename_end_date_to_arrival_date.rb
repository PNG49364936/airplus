class RenameEndDateToArrivalDate < ActiveRecord::Migration[6.0]
  def change
    rename_column :flights, :end_date, :arrival_date
  end
end
