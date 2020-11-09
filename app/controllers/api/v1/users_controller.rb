class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      user.api_key
      render json: UsersSerializer.new(user), status: :created
    elsif user_params[:email].nil?
      render json: { message: 'Email cannot be blank' }, status: :not_acceptable
    else
      user_params[:password].nil?
      render json: { message: 'Password cannot be blank' }, status: :not_acceptable
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
