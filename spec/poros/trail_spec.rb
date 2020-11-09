require 'rails_helper'

RSpec.describe Trail do
  it 'Has attributes', :vcr do
    coordinates = MapService.get_coordinates('denver,co')
    trails = TrailsService.new.get_trails(coordinates)
    location = Location.new(coordinates)
    location_forecast = Forecast.new(WeatherService.get_forecast(location))
    current_forecast = location_forecast.current_weather
    trail_search = Trail.new({location: 'denver,co', trails: trails, forecast: current_forecast})

    expect(trail_search.location).to be_a(String)
    expect(trail_search.forecast).to be_a(Hash)
    expect(trail_search.forecast[:summary]).to be_a(String)
    expect(trail_search.forecast[:temperature]).to be_a(String)
    expect(trail_search.trails).to be_an(Array)
    expect(trail_search.trails[0]).to be_a(Hash)
    expect(trail_search.trails[0][:name]).to be_a(String)
    expect(trail_search.trails[0][:summary]).to be_a(String)
    expect(trail_search.trails[0][:difficulty]).to be_a(String)
    expect(trail_search.trails[0][:location]).to be_a(String)
  end
end