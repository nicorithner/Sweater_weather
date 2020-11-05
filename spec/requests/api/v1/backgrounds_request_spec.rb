require 'rails_helper'

RSpec.describe 'Api::V1::Backgrounds' do
  describe 'Background API' do
    it "Background request returns a json with image attributes" do
      VCR.use_cassette('background') do
        get '/api/v1/backgrounds?location=denver,co'
        json = JSON.parse(response.body, symbolize_names: :true)
        binding.pry
        expect(response).to be_successful
        expect(json[:data]).to have_key(:id)
        expect(json[:data]).to have_key(:type)
        expect(json[:data]).to have_key(:image)
        expect(json[:data][:attributes][:image]).to have_key(:location)
        expect(json[:data][:attributes][:image]).to have_key(:image_url)
        expect(json[:data][:attributes][:image]).to have_key(:credit)
        expect(json[:data][:attributes][:image][:credit]).to have_key(:source)
        expect(json[:data][:attributes][:image][:credit]).to have_key(:author)
        expect(json[:data][:attributes][:image][:credit]).to have_key(:logo)
      end
    end
  end
end