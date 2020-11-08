class RoadTripSerializer
  include JSONAPI::Serializer
  attributes :id, :origin, :destination, :duration, :temperature, :description
end
