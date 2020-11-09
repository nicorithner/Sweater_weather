require 'rails_helper'

RSpec.describe 'Roadtrip Facade' do
  it 'Expose a json with roadtrip information' do
    VCR.use_cassette('Roadtrip_facade_test') do
      roadtrip_params = ({origin: "New York, NY", destination: "Los Angeles, CA", user_id: '5'})
      forecast = RoadtripFacade.get_trip_data(roadtrip_params)

      expect(forecast).to be_a(RoadTrip)
      expect(forecast.origin).to eq('New York, NY')
      expect(forecast.destination).to eq('Los Angeles, CA')
      expect(forecast.user_id).to be_a(Numeric)
      expect(forecast.duration).to be_a(String)
      expect(forecast.temperature).to be_a(String)
      expect(forecast.description).to be_a(String)
    end
  end
end