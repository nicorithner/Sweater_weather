class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    verify(user, params)
  end

  private

  def verify(user, params)
    if params[:origin].nil?
      render json: { message: 'Origin cannot be blank' }, status: :not_acceptable
    elsif params[:destination].nil?
      render json: { message: 'Destination cannot be blank' }, status: :not_acceptable
    elsif user
      road_trip(user, params)
    else
      render json: { message: 'Incorrect credentials' }, status: :unauthorized
    end
  end

  def road_trip(user, params)
    road_trip_params = { origin: params[:origin], destination: params[:destination], user_id: user.id }
    road_trip = RoadtripFacade.get_trip_data(road_trip_params)
    render json: RoadTripSerializer.new(road_trip)
  end
end
