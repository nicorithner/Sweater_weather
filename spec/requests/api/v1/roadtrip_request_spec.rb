require 'rails_helper'

RSpec.describe "Roadtrip Api" do
  before :each do
      user_params = ({ email: 'whatever@example.com', password: 'password', password_confirmation: 'password' })
      headers = {'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
      @json = JSON.parse(response.body, symbolize_names: true)
      @api_key = @json[:data][:attributes][:api_key]
    end
  describe "A successful request returns roadtrip data" do

    it "Gets a successful response and json with roadtrip's attributes" do
      VCR.use_cassette('road_trip_complete') do
        
        roadtrip_params = ({origin: "New York, NY", destination: "Los Angeles, CA", api_key: @api_key})
        headers = {'CONTENT_TYPE' => 'application/json'}
        post '/api/v1/road_trip', headers: headers, params: JSON.generate(roadtrip_params)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(json[:data]).to be_a(Hash)
        expect(json[:data][:id]).to eq(nil)
        expect(json[:data][:type]).to eq("road_trip")
        expect(json[:data][:attributes][:start_city]).to eq("New York, NY")
        expect(json[:data][:attributes][:end_city]).to eq("Los Angeles, CA")
        expect(json[:data][:attributes][:travel_time]).to be_a(String)
        expect(json[:data][:attributes][:travel_time]).to eq("40 hours, 30 minutes")
        expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(String)
        expect(json[:data][:attributes][:weather_at_eta][:temperature].length).to eq(5)
        expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
        expect(json[:data][:attributes][:weather_at_eta][:conditions]).to eq("clear sky")
      end
    end
  end

  describe "Test for sad path. An unsuccessful request returns corresponding 400 status body with error description" do
    it "Blank origin request returns status 406 and a body with error description" do
      VCR.use_cassette('sad_road_trip_complete') do
        roadtrip_params = ({destination: "Los Angeles, CA", api_key: @api_key})
        headers = {'CONTENT_TYPE' => 'application/json'}

        post '/api/v1/road_trip', headers: headers, params: JSON.generate(roadtrip_params)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).not_to be_successful
        expect(response).to have_http_status(406)
        expect(json[:message]).to eq('Origin cannot be blank')
      end
    end

    it "Blank password request returns status 406 and a body with error description" do
      VCR.use_cassette('sad_road_trip_complete') do
        roadtrip_params = ({origin: "New York, NY", api_key: @api_key})
        headers = {'CONTENT_TYPE' => 'application/json'}

        post '/api/v1/road_trip', headers: headers, params: JSON.generate(roadtrip_params)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).not_to be_successful
        expect(response).to have_http_status(406)
        expect(json[:message]).to eq('Destination cannot be blank')
      end
    end

    it "Bad credetianls request returns status 401 and a body with error description" do
      VCR.use_cassette('sad_road_trip_complete') do
        roadtrip_params = ({origin: "New York, NY", destination: "Los Angeles, CA", api_key: "bad credentials"})
        headers = {'CONTENT_TYPE' => 'application/json'}

        post '/api/v1/road_trip', headers: headers, params: JSON.generate(roadtrip_params)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).not_to be_successful
        expect(response).to have_http_status(401)
        expect(json[:message]).to eq('Incorrect credentials')
      end
    end

    it "A request to a location overseas returns status 406 and a body with error description", :vcr do
        roadtrip_params = ({origin: "New York, NY", destination: "London, UK", api_key: @api_key})
        headers = {'CONTENT_TYPE' => 'application/json'}

        post '/api/v1/road_trip', headers: headers, params: JSON.generate(roadtrip_params)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).not_to be_successful
        expect(response).to have_http_status(406)
        expect(json[:message]).to eq('We are unable to route with the given locations.')
    end
  end
end