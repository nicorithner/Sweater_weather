class WeatherService
  def self.get_forecast(location)
    response = conn.get('data/2.5/onecall?') do |f|
      f.params[:appid] = ENV['WEATHER_API_KEY']
      f.params[:lat] = location.latitude
      f.params[:lon] = location.longitude
      f.params[:units] = 'imperial'
      f.params[:exclude] = 'minutely'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.openweathermap.org/')
  end
end
