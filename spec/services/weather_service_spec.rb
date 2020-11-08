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
      trip = MapService.get_route('New York, NY', 'Los Angeles, CA')
      dest_coords = MapService.get_coordinates('Los Angeles, CA')
      days = (trip[:route][:time].to_f / 60 / 60 / 24).round(2)
      eta = (DateTime.now + days).beginning_of_hour.to_i
      eta_forecast = WeatherService.get_eta_forecast(dest_coords, eta)
      
      expect(eta_forecast).to be_a(Hash)
      expect(eta_forecast).to have_key(:dt)
      expect(eta_forecast).to have_key(:temp)
      expect(eta_forecast[:weather][0]).to have_key(:description)
      expect(eta_forecast[:dt]).to be_a(Numeric)
      expect(eta_forecast[:temp]).to be_a(Numeric)
      expect(eta_forecast[:weather][0][:description]).to be_a(String)
    end
  end
end