require 'rails_helper'

describe Image do
  it 'has attributes' do
    VCR.use_cassette('background') do
      data = ImageService.get_image('denver, co')
      background_image = Image.new(data)

      expect(background_image).to be_a(Image)
      expect(background_image.id).to eq(nil) 
      expect(background_image.type).to be_a(String) 
      expect(background_image.location).to be_a(String) 
      expect(background_image.image_url).to be_a(String) 
      expect(background_image.source).to be_a(String) 
      expect(background_image.author).to be_a(String) 
      expect(background_image.logo).to be_a(String)
    end 
  end
end