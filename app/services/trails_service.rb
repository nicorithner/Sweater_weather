class TrailsService

  def get_trails(coordinates)
    response = conn.get('data/get-trails') do |f|
      f.params[:key] = ENV['TRAILS_API_KEY']
      f.params[:lat] = coordinates[:lat]
      f.params[:lon] = coordinates[:lng]
      f.params[:maxDistance] = 10
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://www.hikingproject.com/')
  end
end