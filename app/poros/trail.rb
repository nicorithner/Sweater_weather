class Trail
  attr_reader :id, :location, :forecast, :trails
  def initialize(data)
    @location = data[:location]
    @forecast = {summary: data[:forecast][:weather][0][:description], temperature: data[:forecast][:temp].to_s }
    @trails = data[:trails][:trails]
  end

  # def trails_data(data)
  #   trails = []
  #   data.each do |trail|
  #     trail = {}
  #     trail[:name] = trail[:name]
  #     trail[:summary] = trail[:summary]
  #     trail[:difficulty] = trail[:difficulty]
  #     trail[:location] = trail[:location]
  #     trail[:distance_to_trail] = MapService.get_route(@location, trail[:location])
  #     trails << trail
  #   end
  #   trails
  #   binding.pry
  # end
end
