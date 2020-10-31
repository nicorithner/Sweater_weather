require 'rails_helper'

RSpec.describe 'Forecast Facade' do
  it 'Expose a json with the weather for the city queried' do
    VCR.use_cassette('facade_test') do
      location = 'denver,co'
      forecast = ForecastFacade.get_forecast(location)

      expect(forecast).to be_a(Forecast)
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.current_weather).to have_key(:wind_speed)
    end
  end
end