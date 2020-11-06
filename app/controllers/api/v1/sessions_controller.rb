class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: SessionsSerializer.new(user), status: :ok
    else
      render json: {}, status: :unauthorized 
      #syntax error fixed when I added curlies

      # here error message. How to return a body with error description???

      # An unsuccessful request returns an appropriate 400-level status code and body with a description of why the request wasn’t successful.
      # Potential reasons a request would fail: credentials are bad, etc
    end
  end
end