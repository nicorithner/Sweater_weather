require 'rails_helper'

RSpec.describe 'Api::V1::Forecasts', type: :request do
  describe 'Forecast API' do
    it 'Return specific city-state forecast data' do
      VCR.use_cassette('forecast_search') do
        get '/api/v1/forecast?location=denver, co'
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(json).to have_key(:data)
        expect(json[:data]).to have_key(:id)
        expect(json[:data]).to have_key(:type)
        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to have_key(:current_weather)
        expect(json[:data][:attributes]).to have_key(:daily_weather)
        expect(json[:data][:attributes][:daily_weather].count).to eq(5)
        expect(json[:data][:attributes]).to have_key(:hourly_weather)
        expect(json[:data][:attributes]).to_not have_key(:minutely_weather)

        expect(json[:data][:type]).to eq('forecast')
        expect(json[:data][:attributes][:timezone]).to be_a(String)
        expect(json[:data][:attributes][:current_weather][:sunrise]).to be_a(Integer)
        expect(json[:data][:attributes][:current_weather][:sunset]).to be_a(Integer)
        expect(json[:data][:attributes][:current_weather][:temp]).to be_a(Float)
        expect(json[:data][:attributes][:current_weather][:weather][0][:description]).to be_a(String)
        expect(json[:data][:attributes][:hourly_weather][0][:wind_speed]).to be_a(Float)
      end
    end
  end
end
