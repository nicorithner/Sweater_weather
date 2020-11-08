class RoadTripSerializer
  include JSONAPI::Serializer
  set_id{nil}

  attribute :start_city do |object|
    object.origin
  end

  attribute :end_city do |object|
    object.destination
  end

  attribute :travel_time do |object|
    object.duration
  end

  attribute :weather_at_eta do |object|
    {temperature: object.temperature, conditions: object.description}
  end
end
