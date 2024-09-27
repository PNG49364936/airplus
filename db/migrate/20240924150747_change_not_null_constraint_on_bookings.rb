class ChangeNotNullConstraintOnBookings < ActiveRecord::Migration[6.0]
  def change
    change_column_null :bookings, :customer_id, true
  end
end
