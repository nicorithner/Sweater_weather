class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    save_user(user, params)
  end

  private

  def save_user(user, user_params)
    serialize_user(user) unless screen_fields(user_params)
  end

  def serialize_user(user)
    user.save
    user.api_key
    render json: UsersSerializer.new(user), status: :created
  end
  
  def screen_fields(user_params)
    if User.find_by(email: user_params[:email])
      render json: { message: 'Email already exists' }, status: :not_acceptable
    elsif user_params[:email].nil?
      render json: { message: 'Email cannot be blank' }, status: :not_acceptable
    elsif user_params[:password].nil?
      render json: { message: 'Password cannot be blank' }, status: :not_acceptable
    elsif user_params[:password_confirmation] != user_params[:password]
      render json: { message: "Passwords don't match" }, status: :not_acceptable
    end
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
