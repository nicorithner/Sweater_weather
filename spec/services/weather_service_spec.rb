require 'rails_helper'

RSpec.describe WeatherService do
  it 'can get the forecast from lat/long coordinates' do
    VCR.use_cassette('forecast_search') do
      coordinates = { lat: 39.738453, lng: -104.984853 }
      forecast = WeatherService.get_forecast(coordinates)

      expect(forecast).to be_a(Hash)
      expect(forecast[:current]).to have_key(:sunrise)
      expect(forecast[:current]).to have_key(:sunset)
      expect(forecast[:current]).to have_key(:temp)
      expect(forecast[:current]).to have_key(:pressure)
    end
  end
end