class ForecastFacade

  def self.get_forecast(location)
    coordinates = MapService.get_coordinates(location)
    location = Location.new(coordinates)
    Forecast.new(WeatherService.get_forecast(location))
  end
end