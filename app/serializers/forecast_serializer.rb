class ForecastSerializer
  include JSONAPI::Serializer
  set_id { nil }
  attributes :type, :current_weather, :daily_weather, :hourly_weather, :timezone

  attributes :current_weather do |object|
    {
      "date": Time.at(object.current_weather[:dt]),
      "sunrise": Time.at(object.current_weather[:sunrise]),
      "sunset": Time.at(object.current_weather[:sunset]),
      "temperature": object.current_weather[:temp],
      "feels_like": object.current_weather[:feels_like],
      "humidity": object.current_weather[:humidity],
      "uvi": object.current_weather[:uvi],
      "visibility": object.current_weather[:visibility],
      "conditions": object.current_weather[:weather][0][:description],
      "icon": object.current_weather[:weather][0][:icon]
    }
  end

  attributes :daily_weather do |object|
    object.daily_weather.map do |day|
      {
        "date": Time.at(day[:dt]),
        "sunrise": Time.at(day[:sunrise]),
        "sunset": Time.at(day[:sunset]),
        "max_temp": day[:temp][:max],
        "min_temp": day[:temp][:min],
        "conditions": day[:weather][0][:description],
        "icon": day[:weather][0][:icon]
      }
    end
  end

  attributes :hourly_weather do |object|
    object.hourly_weather.map do |hour|
      {
        "time": Time.at(hour[:dt]),
        "temperature": hour[:temp],
        "wind_speed": "#{hour[:wind_speed]} mph",
        "wind_direction": wind_direction(hour[:wind_deg]),
        "conditions": hour[:weather][0][:description],
        "icon": hour[:weather][0][:icon]
      }
    end
  end

  def self.wind_direction(deg)
    val = (deg / 22.5) + 0.5
    dir = %w[N NNE NE ENE E ESE SE SSE S SSW SW WSW W WNW NW NNW]
    "from #{dir[(val % dir.length)]}"
  end
end
