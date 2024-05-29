class RemoveHaulFromRegistrations < ActiveRecord::Migration[6.0]
  def change
    remove_column :registrations, :haul, :string
  end
end
