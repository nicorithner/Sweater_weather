require 'rails_helper'

RSpec.describe MapService do
  it "Can get longitude and latitude of queried city/state location" do
    VCR.use_cassette('lat_lng_search') do
      location = MapService.get_coordinates('denver, co')
      
      expect(location).to be_a(Hash)
      expect(location[:lat]).to eq(39.738453)
      expect(location[:lng]).to eq(-104.984853)
    end
  end

  it 'can get the route between an origin and destination' do
    VCR.use_cassette('road_trip') do
      origin = 'New York, NY'
      destination = 'Los Angeles, CA'

      data = MapService.get_route(origin, destination)

      expect(data).to be_a(Hash)
      expect(data[:route][:time]).to be_a(Numeric)
      expect(data[:route][:formattedTime]).to be_a(String)
      expect(data[:route][:distance]).to be_a(Numeric)
      expect(data[:route][:locations].last[:latLng]).to be_a(Hash)
    end
  end
end
