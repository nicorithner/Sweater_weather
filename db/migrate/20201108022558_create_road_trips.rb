class CreateRoadTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :road_trips do |t|
      t.references :user, null: false, foreign_key: true
      t.string :origin
      t.string :destination
      t.string :duration
      t.string :temperature
      t.string :description
    end
  end
end
