class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      # trip_data = RoadTripFacade.get_trip_data(params[:origin], params[:destination])
      
      # trip = Mapservice to get travel_time
      # destination = Mapservice to get destination lat and long
      # ETA = Add travel time to time.now to calculate ETA
      # ETA_weather = Weatherservice to get weather at ETA
      # create object. user.roadtrips.create(origin: trip[:origin], destination: trip[:destination] , duration: trip[:duration], temperature: ETA_weather[:temperature] , description: ETA_weather[:description] )
      json = render json: RoadTripSerializer.new(trip_data), status: :ok
      binding.pry
    elsif params[:origin].nil?
      render json: { message: 'Origin cannot be blank' }, status: :not_acceptable
    elsif params[:destination].nil?
      render json: { message: 'Destination cannot be blank' }, status: :not_acceptable
    else
      render json: { message: 'Incorrect credentials' }, status: :unauthorized
    end
    
  end
end