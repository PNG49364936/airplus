class CreateRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :registrations do |t|
      t.string :reg

      t.timestamps
    end
  end
end
