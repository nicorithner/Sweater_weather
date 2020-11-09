require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'Validations' do
    it {should validate_presence_of :origin}
    it {should validate_presence_of :destination}
    it {should validate_presence_of :duration}
    it {should validate_presence_of :temperature}
    it {should validate_presence_of :description}
  end

  describe 'Associations' do
    it {belong_to :user}
  end
end