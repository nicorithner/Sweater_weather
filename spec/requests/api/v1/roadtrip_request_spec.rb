require 'rails_helper'

RSpec.describe "Roadtrip Api" do
  describe "A successful request returns roadtrip data" do

    before :each do
      #===== Create user and expose api_key
      user_params = ({ email: 'whatever@example.com', password: 'password', password_confirmation: 'password' })
      headers = {'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
      @json = JSON.parse(response.body, symbolize_names: true)
      @api_key = @json[:data][:attributes][:api_key]
    end

    it "Gets a successful response and json with roadtrip's attributes" do
      roadtrip_params = ({origin: "New York, NY", destination: "Los Angeles, CA", api_key: @api_key})
      post '/api/v1/road_trip', headers: headers, params: JSON.generate(roadtrip_params)
      json = JSON.parse(response.body, symbolize_names: true)
      
      binding.pry
      ## Here will add expectations test
    end
  end
end