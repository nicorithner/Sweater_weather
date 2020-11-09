class ImageSerializer
  include JSONAPI::Serializer
  attribute :image do |object|
    { location: object.location,
      image_url: object.image_url,
      credit: { source: object.source,
                author: object.author,
                logo: object.logo } }
  end
end
