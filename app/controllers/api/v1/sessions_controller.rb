class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: SessionsSerializer.new(user), status: :ok
    elsif
      params[:email].nil?
      render json: { message: 'Email cannot be blank' }, status: :not_acceptable 
    elsif
      params[:password].nil?
      render json: { message: 'Password cannot be blank' }, status: :not_acceptable 
    else
      render json: { message: 'Your email or password was incorrect' }, status: :unauthorized
    end
  end
end
