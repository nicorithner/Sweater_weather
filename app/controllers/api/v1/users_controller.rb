class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    save_user(user)
  end

  private

  def save_user(user)
    if user.valid?
      user.save
      user.api_key
      render json: UsersSerializer.new(user), status: :created
    else
      render json: {errors: user.errors.full_messages},  status: :not_acceptable
    end
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
