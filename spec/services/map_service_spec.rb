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
end