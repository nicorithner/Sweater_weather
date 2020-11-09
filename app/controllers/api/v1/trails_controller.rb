class Api::V1::TrailsController < ApplicationController
  def index
    coordinates = MapService.get_coordinates(params[:location])
    binding.pry
  end
end

=begin
Notes:
index params
  => <ActionController::Parameters {"location"=>"denver,co", "controller"=>"api/v1/trails", "action"=>"index"} permitted: false>
=end