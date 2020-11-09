class Api::V1::TrailsController < ApplicationController
  def index
    coordinates = MapService.get_coordinates(params[:location])
    trails = TrailsService.new.get_trails(coordinates)
    location = Location.new(coordinates)
    location_forecast = Forecast.new(WeatherService.get_forecast(location))
    current_forecast = location_forecast.current_weather

    trails_search = Trail.new(trails, current_forecast)
    render json: TrailsSerializer.new(trails_search)
  end
end

=begin
Notes:
index params
  => <ActionController::Parameters {"location"=>"denver,co", "controller"=>"api/v1/trails", "action"=>"index"} permitted: false>

trails call: https://www.hikingproject.com/data/get-trails?lat=39.738453&lon=-104.984853&maxDistance=10&key=200545096-5f955e77feb9332b7dc97751e8ac525e

current_forecast[:temp] => 34.34
current_forecast[:weather][0][:description] => "broken clouds"

=end