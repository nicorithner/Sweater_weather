class ImageService

  def self.conn
    Faraday.new('https://api.bing.microsoft.com/')
  end

  def self.get_image(location)
    response = conn.get('v7.0/images/search?') do |f|
      f.headers['Ocp-Apim-Subscription-Key'] = ENV['IMAGE_API_KEY']
      f.params['q'] = location
      f.params['imageType'] = 'Photo'
      f.params['size'] = 'Large'
      f.params['count'] = '10'
      f.params['safeSearch'] = 'Strict'
    end

    json = JSON.parse(response.body, symbolize_names: true)
    {images: get_image_collection(json), location: location}
  end

  def self.get_image_collection(json)
    json[:value].map do |image|
        image[:contentUrl]
    end
  end
end
