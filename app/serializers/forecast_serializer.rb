class ForecastSerializer
  include JSONAPI::Serializer
  set_id { nil }
  attributes :type, :current_weather, :daily_weather, :hourly_weather, :timezone
end
