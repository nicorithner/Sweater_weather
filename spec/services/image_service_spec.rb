require 'rails_helper'

RSpec.describe ImageService do
  it "Can get a city background image from a query" do
    VCR.use_cassette('background') do
      location = 'denver, co'
      image = ImageService.get_image(location)

      expect(image).to be_an(Hash)
      expect(image[:json]).to be_a(Hash)
      expect(image[:json][:id]).to be_a(Numeric)
      expect(image[:json][:type]).to be_a(String)
      expect(image[:json][:webformatURL]).to be_a(String)
      expect(image[:json][:user]).to be_a(String)
      expect(image[:json][:tags]).to include('denver')

      expect(image[:other]).to be_a(Hash)
      expect(image[:other][:location]).to be_a(String)
      expect(image[:other][:source]).to be_a(String)
      expect(image[:other][:logo]).to be_a(String)
    end
  end
end