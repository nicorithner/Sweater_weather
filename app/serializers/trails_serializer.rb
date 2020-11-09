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
        "location": trail[:location]
      }
    end
  end

end
