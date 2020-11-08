class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      # trip_data = RoadTripFacade.get_trip_data(params[:origin], params[:destination])
      
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