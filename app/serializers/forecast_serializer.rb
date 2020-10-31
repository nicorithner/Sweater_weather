class ForecastSerializer
  include JSONAPI::Serializer
  attributes :id, :type, :current_weather, :daily_weather, :hourly_weather, :timezone

  attribute :attributes do |object|
    { current_weather: object.current_weather, daily_weather: object.daily_weather, hourly_weather: object.hourly_weather, timezone: object.timezone }
  end
end
