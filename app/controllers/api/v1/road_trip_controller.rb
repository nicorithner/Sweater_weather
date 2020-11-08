class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      # trip_data = RoadTripFacade.get_trip_data(params[:origin], params[:destination])
      trip = MapService.get_route(params[:origin], params[:destination])
      dest_coords = MapService.get_coordinates(params[:destination])
      days = (trip[:route][:time].to_f / 60 / 60 / 24).round(2)
      eta = (DateTime.now + days).beginning_of_hour.to_i # => Tue, 10 Nov 2020 02:00:00 -0700
      eta_forecast = WeatherService.get_eta_forecast(dest_coords, eta)
      road_trip = RoadTrip.create(origin: params[:origin], destination: params[:destination] , duration: trip[:route][:formattedTime], temperature: eta_forecast[:temp] , description: eta_forecast[:weather][0][:description], user_id: user.id )
      render json: RoadTripSerializer.new(road_trip)
    elsif params[:origin].nil?
      render json: { message: 'Origin cannot be blank' }, status: :not_acceptable
    elsif params[:destination].nil?
      render json: { message: 'Destination cannot be blank' }, status: :not_acceptable
    else
      render json: { message: 'Incorrect credentials' }, status: :unauthorized
    end
    
  end
end
