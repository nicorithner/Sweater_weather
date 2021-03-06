require 'rails_helper'

RSpec.describe ImageService do
  it "Can get a city background image from a query", :vcr do
      location = 'denver, co'
      data = ImageService.get_image(location)

      expect(data).to be_an(Hash)
      expect(data[:images]).to be_a(Array)
      expect(data[:images].count).to eq(10)
      expect(data[:location]).to be_a(String)
      expect(data[:location]).to eq(location)

      data[:images].each do |link|
        expect(link).to be_a(String)
        expect(link.downcase).to include('jpg').or include('png').or include('jpeg')
      end
  end
end