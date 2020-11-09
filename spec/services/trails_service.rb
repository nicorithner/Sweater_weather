require 'rails_helper'

RSpec.describe TrailsService do
  it 'Can get a list of trails near search location' do
    VCR.use_cassette('Trails_search') do
      coordinates = {lat: 39.738453, lng: -104.984853}
      search_results = TrailService.new.get_trails(coordinates)

      expect(search_results).to be_a(Hash)
      expect(search_results[:trails]).to be_an(Array)
      expect(search_results[:trails][0]).to be_a(Hash)
      expect(search_results[:trails][0][:id]).to be_a(Numeric)
      expect(search_results[:trails][0][:name]).to be_a(String)
      expect(search_results[:trails][0][:summary]).to be_a(String)
      expect(search_results[:trails][0][:difficulty]).to be_a(String)
      expect(search_results[:trails][0][:location]).to be_a(String)
    end
  end
end