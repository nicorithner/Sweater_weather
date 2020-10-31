class Api::V1::ForecastController < ApplicationController
  def index
    coordinates = MapService.get_coordinates(params[:location])
    location = Location.new(coordinates)
    forecast = Forecast.new(WeatherService.get_forecast(location))
    json = render json: ForecastSerializer.new(forecast)
  end
end