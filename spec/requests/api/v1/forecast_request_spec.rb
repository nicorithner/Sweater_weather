require 'rails_helper'

RSpec.describe 'Api::V1::Forecasts', type: :request do
  describe 'Forecast API' do
    it 'Return specific city-state forecast data' do
      VCR.use_cassette('forecast_search') do
        get '/api/v1/forecast?location=denver, co'
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(json[:data]).to have_key(:id)
        expect(json[:data]).to have_key(:type)
        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to have_key(:current_weather)
        expect(json[:data][:attributes]).to have_key(:daily_weather)
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

# json[:current].keys
# => [:dt, :sunrise, :sunset, :temp, :feels_like, :pressure, :humidity, :dew_point, :uvi, :clouds, :visibility, :wind_speed, :wind_deg, :weather]

## in the controller index getting this 
# forecast.keys
# => [:lat, :lon, :timezone, :timezone_offset, :current, :hourly, :daily]

=begin 

Response:

The response data should contain exactly these elements and nothing more:

a data attribute, under which all other attributes are present:
  id, always set to null
  type, always set to “forecast”
  attributes, an object containing weather information:
    current_weather, holds current weather data:
      datetime, in a human-readable format such as “2020-09-30 13:27:03 -0600”
      sunrise, in a human-readable format such as “2020-09-30 06:27:03 -0600”
      sunset, in a human-readable format such as “2020-09-30 18:27:03 -0600”
      temperature, floating point number indicating the current temperature in Fahrenheit
      feels_like, floating point number indicating a temperature in Fahrenheit
      humidity, numeric (int or float), as given by OpenWeather
      uvi, numeric (int or float), as given by OpenWeather
      visibility, numeric (int or float), as given by OpenWeather
      conditions, the first ‘description’ field from the weather data as given by OpenWeather
      icon, string, as given by OpenWeather
    daily_weather, array of the next 5 days of daily weather data:
      date, in a human-readable format such as “2020-09-30”
      sunrise, in a human-readable format such as “2020-09-30 06:27:03 -0600”
      sunset, in a human-readable format such as “2020-09-30 18:27:03 -0600”
      max_temp, floating point number indicating the maximum expected temperature in Fahrenheit
      min_temp, floating point number indicating the minimum expected temperature in Fahrenheit
      conditions, the first ‘description’ field from the weather data as given by OpenWeather
      icon, string, as given by OpenWeather
    hourly_weather, array of the next 8 hours of hourly weather data:
      time, in a human-readable format such as “14:00:00”
      wind_speed, string, in miles per hour
      wind_direction, string, check wikipedia for how to convert this numeric value
      conditions, the first ‘description’ field from the weather data as given by OpenWeather
      icon, string, as given by OpenWeather


=end