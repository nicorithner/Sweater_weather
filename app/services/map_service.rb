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

  def self.get_route(origin, destination)
    response = conn.get('directions/v2/route') do |f|
      f.params[:key] = ENV['MAP_API_KEY']
      f.params[:from] = origin
      f.params[:to] = destination
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://www.mapquestapi.com/')
  end


end
#http://www.mapquestapi.com/directions/v2/route?key=lEqLhOepdVCpmyz6y6eMQZt8jtRBUO0b&from=New York, NY&to=Los Angeles, CA