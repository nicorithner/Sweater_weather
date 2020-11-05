class ImageService
  def self.get_image(location)
    response = conn.get('api/') do |f|
      f.params['key'] = ENV['IMAGE_API_KEY']
      f.params['q'] = location.split(',')[0]
      f.params['image_type'] = 'photo'
      f.params['orientation'] = 'horizontal'
    end

    json = JSON.parse(response.body, symbolize_names: true)
    {json: json[:hits][0], other: {location: location, source: "pixabay.com", logo:"https://pixabay.com/static/img/logo_square.png"}}
  end

  def self.conn
    Faraday.new('https://pixabay.com/')
  end
end
