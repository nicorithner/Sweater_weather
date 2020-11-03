require 'rails_helper'

RSpec.describe ImageService do
  it "Can get a city background image from a query" do
    VCR.use_cassette('background') do
      location = 'denver, co'
      background = ImageService.get_image(location)

      expect(background).to be_a(Hash)
      expect(background[:id]).to be_a(Numeric)
      expect(background[:tags]).to include('denver')
      expect(background[:largeImageURL]).to be_a(String)
    end
  end
end