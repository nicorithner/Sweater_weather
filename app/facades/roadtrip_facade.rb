class RoadtripFacade
  def self.get_trip_data(params)
    trip = MapService.get_route(params[:origin], params[:destination])
    eta_forecast = find_eta_forecast(params, trip)
    create_trip(params, trip, eta_forecast)
  end

  def self.find_eta_forecast(params, trip)
    dest_coords = MapService.get_coordinates(params[:destination])
    days = (trip[:route][:time].to_f / 60 / 60 / 24).round(2)
    eta = (DateTime.now + days).beginning_of_hour.to_i
    WeatherService.get_eta_forecast(dest_coords, eta)
  end

  def self.create_trip(params, trip, eta_forecast)
    time = trip[:route][:formattedTime]
    RoadTrip.create(origin: params[:origin],
                    destination: params[:destination],
                    duration: "#{time[0, 1]} hours, #{time[3..4]} minutes",
                    temperature: eta_forecast[:temp],
                    description: eta_forecast[:weather][0][:description],
                    user_id: params[:user_id])
  end
end
