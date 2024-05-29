class AddHaulIdToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :haul_id, :integer
  end
end
