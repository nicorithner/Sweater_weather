class Api::V1::BackgroundsController < ApplicationController
  def index
    image = BackgroundsFacade.get_image(params[:location])
    render json: ImageSerializer.new(image)
  end
end