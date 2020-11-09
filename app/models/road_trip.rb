class RoadTrip < ApplicationRecord
  validates :origin, :destination, :duration, :temperature, :description, presence: true
  belongs_to :user
end
