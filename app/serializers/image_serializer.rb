class ImageSerializer
  include JSONAPI::Serializer
  attribute :image do |object|
    { location: object.location,
      image_url: object.image_url }
  end
end
