class TrailsSerializer
  include JSONAPI::Serializer
  set_id{nil}
  attributes :location, :forecast

  attribute :trails do |object|
    object.trails.map do |trail|
      {
        "name": trail[:name],
        "summary": trail[:summary],
        "difficulty": trail[:difficulty],
        "location": trail[:location],
        "distance_to_trail":( MapService.get_route(object.location, trail[:location]))[:route][:distance]
      }
    end
  end

end
