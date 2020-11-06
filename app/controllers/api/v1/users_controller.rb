class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user.save
    user.api_key
    # binding.pry
    render json: UsersSerializer.new(user)
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end