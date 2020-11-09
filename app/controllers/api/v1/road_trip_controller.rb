class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      road_trip = RoadtripFacade.get_trip_data({origin: params[:origin], destination: params[:destination], user_id: user.id} )
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
