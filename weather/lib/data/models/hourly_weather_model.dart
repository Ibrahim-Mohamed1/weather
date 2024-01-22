import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.kebab)
class HourlyWeatherData {
  double latitude, longitude, generationTimeMs, elevation;
  String timezone, timezoneAbbreviation;
  int utcOffsetSeconds;
  HourlyUnits hourlyUnits;
  Hourly hourly;

  HourlyWeatherData(
      {required this.latitude,
      required this.longitude,
      required this.generationTimeMs,
      required this.utcOffsetSeconds,
      required this.timezone,
      required this.timezoneAbbreviation,
      required this.elevation,
      required this.hourlyUnits,
      required this.hourly});

  factory HourlyWeatherData.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherData(
        latitude: json['latitude'],
        longitude: json['longitude'],
        generationTimeMs: json['generationtime_ms'],
        utcOffsetSeconds: json['utc_offset_seconds'],
        timezone: json['timezone'],
        timezoneAbbreviation: json['timezone_abbreviation'],
        elevation: json['elevation'],
        hourlyUnits: HourlyUnits.fromJson(json['hourly_units']),
        hourly: Hourly.fromJson(json['hourly']));
  }
}

class HourlyUnits {
  String time,
      temperature2m,
      relativeHumidity2m,
      dewPoint2m,
      precipitationProbability,
      cloudCover,
      visibility,
      windSpeed10m,
      windDirection10m,
      windGusts10m,
      temperature80m;

  HourlyUnits(
      {required this.time,
      required this.temperature2m,
      required this.relativeHumidity2m,
      required this.dewPoint2m,
      required this.precipitationProbability,
      required this.cloudCover,
      required this.visibility,
      required this.windSpeed10m,
      required this.windDirection10m,
      required this.windGusts10m,
      required this.temperature80m});

  factory HourlyUnits.fromJson(Map<String, dynamic> json) {
    return HourlyUnits(
        time: json['time'],
        temperature2m: json['temperature_2m'],
        relativeHumidity2m: json['relative_humidity_2m'],
        dewPoint2m: json['dew_point_2m'],
        precipitationProbability: json['precipitation_probability'],
        cloudCover: json['cloud_cover'],
        visibility: json['visibility'],
        windSpeed10m: json['wind_speed_10m'],
        windDirection10m: json['wind_direction_10m'],
        windGusts10m: json['wind_gusts_10m'],
        temperature80m: json['temperature_80m']);
  }
}

class Hourly {
  List<String> time;
  List<double> temperature2m,
      dewPoint2m,
      visibility,
      windSpeed10m,
      windGusts10m,
      uvIndex;
  List<int> precipitationProbability,
      cloudCover,
      windDirection10m,
      relativeHumidity;

  Hourly(
      {required this.time,
      required this.temperature2m,
      required this.dewPoint2m,
      required this.precipitationProbability,
      required this.cloudCover,
      required this.visibility,
      required this.windSpeed10m,
      required this.windDirection10m,
      required this.windGusts10m,
      required this.uvIndex,
      required this.relativeHumidity});

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
        time: List<String>.from(json['time']),
        temperature2m: List<double>.from(json['temperature_2m']),
        relativeHumidity: List<int>.from(json['relative_humidity_2m']),
        dewPoint2m: List<double>.from(json['dew_point_2m']),
        precipitationProbability:
            List<int>.from(json['precipitation_probability']),
        cloudCover: List<int>.from(json['cloud_cover']),
        visibility: List<double>.from(json['visibility']),
        windSpeed10m: List<double>.from(json['wind_speed_10m']),
        windDirection10m: List<int>.from(json['wind_direction_10m']),
        windGusts10m: List<double>.from(json['wind_gusts_10m']),
        uvIndex: List<double>.from(json['uv_index']));
  }
}
