class MapService
  def self.get_coordinates(location)
    response = conn.get('geocoding/v1/address?') do |f|
      f.params[:key] = ENV['MAP_API_KEY']
      f.params[:location] = location
    end

    json = JSON.parse(response.body, symbolize_names: true)
    json[:results][0][:locations][0][:latLng]
  end

  def self.conn
    Faraday.new('https://www.mapquestapi.com/')
  end
end