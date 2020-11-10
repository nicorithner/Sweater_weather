class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    verify(user, params)
  end

  private

  def verify(user, user_params)
    if User.find_by(email: user_params[:email])
      render json: { message: 'Email already exists' }, status: :not_acceptable
    elsif user_params[:email].nil?
      render json: { message: 'Email cannot be blank' }, status: :not_acceptable
    elsif user_params[:password].nil?
      render json: { message: 'Password cannot be blank' }, status: :not_acceptable
    elsif user_params[:password_confirmation] != user_params[:password]
      render json: { message: "Passwords don't match" }, status: :not_acceptable
    else  user.save
          user.api_key
          render json: UsersSerializer.new(user), status: :created
    end
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
