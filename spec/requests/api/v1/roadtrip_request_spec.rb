require 'rails_helper'

RSpec.describe "Roadtrip Api" do
  describe "A successful request returns roadtrip data" do

    before :each do
      user_params = ({ email: 'whatever@example.com', password: 'password', password_confirmation: 'password' })
      headers = {'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
      @json = JSON.parse(response.body, symbolize_names: true)
      @api_key = @json[:data][:attributes][:api_key]
    end

    it "Gets a successful response and json with roadtrip's attributes" do
      VCR.use_cassette('road_trip_complete') do
        
        roadtrip_params = ({origin: "New York, NY", destination: "Los Angeles, CA", api_key: @api_key})
        headers = {'CONTENT_TYPE' => 'application/json'}
        post '/api/v1/road_trip', headers: headers, params: JSON.generate(roadtrip_params)
        json = JSON.parse(response.body, symbolize_names: true)
        
        expect(json[:data]).to be_a(Hash)
        expect(json[:data][:id]).to eq(nil)
        expect(json[:data][:type]).to eq("road_trip")
        expect(json[:data][:attributes][:start_city]).to eq("New York, NY")
        expect(json[:data][:attributes][:end_city]).to eq("Los Angeles, CA")
        expect(json[:data][:attributes][:travel_time]).to be_a(String)
        expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(String)
        expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
      end
    end
  end
end