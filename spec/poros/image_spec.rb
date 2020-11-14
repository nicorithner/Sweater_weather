require 'rails_helper'

describe Image do
  it 'has attributes', :vcr do
      data = ImageService.get_image('denver, co')
      background_image = Image.new(data)
      expect(background_image).to be_a(Image)
      expect(background_image.id).to eq(nil) 
      expect(background_image.location).to be_a(String) 
      expect(background_image.image_url).to be_a(String) 
      expect(background_image.image_collection).to be_an(Array) 
      expect(background_image.image_collection.count).to eq(10)
      background_image.image_collection.each do |link| 
        expect(link).to be_a(String)
        expect(link).to include('jpg')
      end
  end
end