require 'rails_helper'

RSpec.describe WeatherService do
  it 'can get the forecast from lat/long coordinates' do
    VCR.use_cassette('forecast_search') do
      coordinates = MapService.get_coordinates('denver, co')
      location = Location.new(coordinates)
      forecast = WeatherService.get_forecast(location)

      expect(forecast).to be_a(Hash)
      expect(forecast[:current]).to have_key(:sunrise)
      expect(forecast[:current]).to have_key(:sunset)
      expect(forecast[:current]).to have_key(:temp)
      expect(forecast[:current]).to have_key(:pressure)
    end
  end
  it 'can get the eta forecast from lat/long coordinates' do
    VCR.use_cassette('eta_forecast_search') do
      coordinates = MapService.get_coordinates('denver, co')
      location = Location.new(coordinates)
      eta_forecast = WeatherService.get_eta_forecast(location)

      expect(eta_forecast).to be_a(Hash)
      expect(eta_forecast).to have_key(:dt)
      expect(eta_forecast).to have_key(:temp)
      expect(eta_forecast).to have_key(:description)
      expect(eta_forecast[:dt]).to be_a(Numeric)
      expect(eta_forecast[:temp]).to be_a(Numeric)
      expect(eta_forecast[:description]).to be_a(String)
    end
  end
end