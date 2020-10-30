require 'rails_helper'

RSpec.describe Location do
  it "Has attributes" do
    data = {:lat=>39.738453, :lng=>-104.984853}
    location = Location.new(data)

    expect(location.latitude).to be_a(Float)
    expect(location.latitude).to eq(39.738453)
    expect(location.longitude).to be_a(Float)
    expect(location.longitude).to eq(-104.984853)
  end
end