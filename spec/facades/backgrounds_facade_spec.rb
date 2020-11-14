require 'rails_helper'

RSpec.describe 'Backgrounds Facade' do
  it 'Expose a json with image attributes' do
    VCR.use_cassette('background') do
      location = 'denver,co'
      background_image = BackgroundsFacade.get_image(location)

      expect(background_image).to be_a(Image)
      expect(background_image.id).to eq(nil) 
      expect(background_image.location).to be_a(String) 
      expect(background_image.image_url).to be_a(String) 
      expect(background_image.image_collection).to be_an(Array)
    end
  end
end