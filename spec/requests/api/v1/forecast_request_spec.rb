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
        expect(json[:data][:type]).to eq('forecast')

        ##==== Attributes
        expect(json[:data][:attributes]).to have_key(:timezone)
        expect(json[:data][:attributes][:timezone]).to be_a(String)
        expect(json[:data][:attributes]).to have_key(:current_weather)
        expect(json[:data][:attributes]).to have_key(:daily_weather)
        expect(json[:data][:attributes]).to have_key(:hourly_weather)
        expect(json[:data][:attributes]).to_not have_key(:minutely_weather)
        
        ##==== Attributes Current Weather
        expect(json[:data][:attributes][:current_weather]).to be_a(Hash)
        expect(json[:data][:attributes][:current_weather].keys.count).to eq(10)
        expect(json[:data][:attributes][:current_weather][:date]).to be_a(String)
        expect(json[:data][:attributes][:current_weather][:sunrise]).to be_a(String)
        expect(json[:data][:attributes][:current_weather][:sunset]).to be_a(String)
        expect(json[:data][:attributes][:current_weather][:temperature]).to be_a(Numeric)
        expect(json[:data][:attributes][:current_weather][:feels_like]).to be_a(Numeric)
        expect(json[:data][:attributes][:current_weather][:humidity]).to be_a(Numeric)
        expect(json[:data][:attributes][:current_weather][:uvi]).to be_a(Numeric)
        expect(json[:data][:attributes][:current_weather][:visibility]).to be_a(Numeric)
        expect(json[:data][:attributes][:current_weather][:conditions]).to be_a(String)
        expect(json[:data][:attributes][:current_weather][:icon]).to be_a(String)
        
        ##==== Attributes Daily Weather
        expect(json[:data][:attributes][:daily_weather]).to be_a(Array)
        expect(json[:data][:attributes][:daily_weather].count).to eq(5)
        expect(json[:data][:attributes][:daily_weather].first.keys.count).to eq(7)
        expect(json[:data][:attributes][:daily_weather].first[:date]).to be_a(String)
        expect(json[:data][:attributes][:daily_weather].first[:sunrise]).to be_a(String)
        expect(json[:data][:attributes][:daily_weather].first[:sunset]).to be_a(String)
        expect(json[:data][:attributes][:daily_weather].first[:max_temp]).to be_a(Numeric)
        expect(json[:data][:attributes][:daily_weather].first[:min_temp]).to be_a(Numeric)
        expect(json[:data][:attributes][:daily_weather].first[:conditions]).to be_a(String)
        expect(json[:data][:attributes][:daily_weather].first[:icon]).to be_a(String)

        ##==== Attributes Hourly Weather
        expect(json[:data][:attributes][:hourly_weather]).to be_an(Array)
        expect(json[:data][:attributes][:hourly_weather].first.keys.count).to eq(6)
        expect(json[:data][:attributes][:hourly_weather].first[:time]).to be_a(String)
        expect(json[:data][:attributes][:hourly_weather].first[:temperature]).to be_a(Numeric)
        expect(json[:data][:attributes][:hourly_weather].first[:wind_speed]).to be_a(String)
        expect(json[:data][:attributes][:hourly_weather].first[:wind_direction]).to be_a(String)
        expect(json[:data][:attributes][:hourly_weather].first[:conditions]).to be_a(String)
        expect(json[:data][:attributes][:hourly_weather].first[:icon]).to be_a(String)
      end
    end
    it "Test it doesn't return certain data" do
      VCR.use_cassette('forecast_search') do
        get '/api/v1/forecast?location=denver, co'
        json = JSON.parse(response.body, symbolize_names: true)

        ##==== Shouldn't Have Attributes
        expect(json[:data][:attributes]).to_not have_key(:minutely_weather)
        
        ##==== Shouldn't Have Attributes Current Weather
        expect(json[:data][:attributes][:current_weather].keys.count).to_not eq(11)
        expect(json[:data][:attributes][:current_weather]).to_not have_key(:pressure)
        expect(json[:data][:attributes][:current_weather]).to_not have_key(:dew_point)
        expect(json[:data][:attributes][:current_weather]).to_not have_key(:clouds)
        expect(json[:data][:attributes][:current_weather]).to_not have_key(:wind_speed)
        expect(json[:data][:attributes][:current_weather]).to_not have_key(:wind_deg)
        expect(json[:data][:attributes][:current_weather]).to_not have_key(:rain)
        expect(json[:data][:attributes][:current_weather]).to_not have_key(:id)
        expect(json[:data][:attributes][:current_weather]).to_not have_key(:main)
        
        ##==== Shouldn't Have Attributes Daily Weather
        expect(json[:data][:attributes][:daily_weather].first.keys.count).to_not eq(8)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:temp)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:feels_like)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:pressure)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:humidity)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:dew_point)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:wind_speed)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:wind_deg)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:clouds)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:pop)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:uvi)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:id)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:main)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:day)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:night)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:eve)
        expect(json[:data][:attributes][:daily_weather].first).to_not have_key(:morn)

        ##==== Shouldn't Have Attributes Hourly Weather
        expect(json[:data][:attributes][:hourly_weather].first.keys.count).to_not eq(7)
        expect(json[:data][:attributes][:hourly_weather].first).to_not have_key(:feels_like)
        expect(json[:data][:attributes][:hourly_weather].first).to_not have_key(:pressure)
        expect(json[:data][:attributes][:hourly_weather].first).to_not have_key(:humidity)
        expect(json[:data][:attributes][:hourly_weather].first).to_not have_key(:dew_point)
        expect(json[:data][:attributes][:hourly_weather].first).to_not have_key(:clouds)
        expect(json[:data][:attributes][:hourly_weather].first).to_not have_key(:visibility)
        expect(json[:data][:attributes][:hourly_weather].first).to_not have_key(:pop)
        expect(json[:data][:attributes][:hourly_weather].first).to_not have_key(:id)
        expect(json[:data][:attributes][:hourly_weather].first).to_not have_key(:main)
      end
    end
  end
end
