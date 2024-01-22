import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.kebab)
class DailyWeatherData {
  double latitude, longitude, generationTimeMs, elevation;
  int utcOffsetSeconds;
  String timezone, timezoneAbbreviation;
  DailyUnits dailyUnits;
  Daily daily;

  DailyWeatherData(
      {required this.latitude,
      required this.longitude,
      required this.generationTimeMs,
      required this.utcOffsetSeconds,
      required this.timezone,
      required this.timezoneAbbreviation,
      required this.elevation,
      required this.dailyUnits,
      required this.daily});

  factory DailyWeatherData.fromJson(Map<String, dynamic> json) {
    return DailyWeatherData(
        latitude: json['latitude'],
        longitude: json['longitude'],
        generationTimeMs: json['generationtime_ms'],
        utcOffsetSeconds: json['utc_offset_seconds'],
        timezone: json['timezone'],
        timezoneAbbreviation: json['timezone_abbreviation'],
        elevation: json['elevation'],
        dailyUnits: DailyUnits.fromJson(json['daily_units']),
        daily: Daily.fromJson(json['daily']));
  }
}

class DailyUnits {
  String time,
      temperature2mMax,
      temperature2mMin,
      sunrise,
      sunset,
      uvIndexMax,
      precipitationSum,
      windSpeed10mMax;

  DailyUnits(
      {required this.time,
      required this.temperature2mMax,
      required this.temperature2mMin,
      required this.sunrise,
      required this.sunset,
      required this.uvIndexMax,
      required this.precipitationSum,
      required this.windSpeed10mMax});

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
        time: json['time'],
        temperature2mMax: json['temperature_2m_max'],
        temperature2mMin: json['temperature_2m_min'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
        uvIndexMax: json['uv_index_max'],
        precipitationSum: json['precipitation_sum'],
        windSpeed10mMax: json['wind_speed_10m_max']);
  }
}

class Daily {
  List<String> time, sunrise, sunset;
  List<int> precipitationProbabilityMax;
  List<double> temperature2mMax,
      temperature2mMin,
      uvIndexMax,
      precipitationSum,
      windSpeed10mMax;

  Daily(
      {required this.time,
      required this.temperature2mMax,
      required this.temperature2mMin,
      required this.sunrise,
      required this.sunset,
      required this.uvIndexMax,
      required this.precipitationSum,
      required this.precipitationProbabilityMax,
      required this.windSpeed10mMax});

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
        time: List<String>.from(json['time']),
        temperature2mMax: List<double>.from(json['temperature_2m_max']),
        temperature2mMin: List<double>.from(json['temperature_2m_min']),
        sunrise: List<String>.from(json['sunrise']),
        sunset: List<String>.from(json['sunset']),
        uvIndexMax: List<double>.from(json['uv_index_max']),
        precipitationSum: List<double>.from(json['precipitation_sum']),
        precipitationProbabilityMax:
            List<int>.from(json['precipitation_probability_max']),
        windSpeed10mMax: List<double>.from(json['wind_speed_10m_max']));
  }
}
