class AddStatusToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :status, :string, default: 'active'
  end
end
