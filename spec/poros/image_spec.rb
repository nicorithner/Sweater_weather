require 'rails_helper'

describe Image do
  it 'has attributes' do
    
    data = ImageService.get_image('denver, co')
    background_image = Image.new(data)

    expect(background_image).to be_a(Image)
    expect(background_image.id).to eq('nil') 
    expect(background_image.type).to be_a(String) 
    expect(background_image.image).to be_a(Hash) 
    expect(background_image.image[:location]).to be_a(String) 
    expect(background_image.image[:image_url]).to be_a(String) 
    expect(background_image.image[:credit]).to be_a(Hash) 
    expect(background_image.image[:credit][:source]).to be_a(String) 
    expect(background_image.image[:credit][:author]).to be_a(String) 
    expect(background_image.image[:credit][:logo]).to be_a(String) 
  end
end