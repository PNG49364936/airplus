class AddDiscardedAtToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :discarded_at, :datetime
  end
end
