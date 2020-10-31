class Forecast
  attr_reader :id, :type, :current_weather, :daily_weather, :hourly_weather, :timezone

  def initialize(data)
    @id = nil
    @type = 'forecast'
    @current_weather = data[:current]
    @daily_weather = data[:daily]
    @hourly_weather = data[:hourly]
    @timezone = data[:timezone]
  end
end
