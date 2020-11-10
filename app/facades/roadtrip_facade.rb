class RoadtripFacade
  def self.get_trip_data(params)
    trip = MapService.get_route(params[:origin], params[:destination])
    dest_coords = MapService.get_coordinates(params[:destination])
    days = (trip[:route][:time].to_f / 60 / 60 / 24).round(2)
    eta = (DateTime.now + days).beginning_of_hour.to_i
    eta_forecast = WeatherService.get_eta_forecast(dest_coords, eta)
    create_trip(params, trip, eta_forecast)
  end

  def self.create_trip(params, trip, eta_forecast)
    RoadTrip.create(origin: params[:origin],
                    destination: params[:destination],
                    duration: trip[:route][:formattedTime],
                    temperature: eta_forecast[:temp],
                    description: eta_forecast[:weather][0][:description],
                    user_id: params[:user_id])
  end
end
