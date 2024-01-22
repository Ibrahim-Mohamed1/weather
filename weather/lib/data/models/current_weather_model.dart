import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.kebab)
class CurrentWeatherData with EquatableMixin {
  double latitude, longitude, generationTimeMs, elevation;
  int utcOffsetSeconds;
  String timezone, timezoneAbbreviation;
  CurrentWeatherUnits currentUnits;
  CurrentWeather current;

  CurrentWeatherData(
      {required this.latitude,
      required this.longitude,
      required this.generationTimeMs,
      required this.utcOffsetSeconds,
      required this.timezone,
      required this.timezoneAbbreviation,
      required this.elevation,
      required this.currentUnits,
      required this.current});

  factory CurrentWeatherData.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      generationTimeMs: json['generationtime_ms'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      currentUnits: CurrentWeatherUnits.fromJson(json['current_units']),
      current: CurrentWeather.fromJson(json['current']),
    );
  }

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        generationTimeMs,
        utcOffsetSeconds,
        timezone,
        timezoneAbbreviation,
        elevation,
        currentUnits,
        current
      ];
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.kebab)
class CurrentWeatherUnits with EquatableMixin {
  String time,
      interval,
      temperature2m,
      relativeHumidity2m,
      apparentTemperature,
      precipitation,
      rain,
      snowfall,
      weatherCode,
      cloudCover,
      windSpeed10m,
      windDirection10m;

  CurrentWeatherUnits(
      {required this.time,
      required this.interval,
      required this.temperature2m,
      required this.relativeHumidity2m,
      required this.apparentTemperature,
      required this.precipitation,
      required this.rain,
      required this.snowfall,
      required this.weatherCode,
      required this.cloudCover,
      required this.windSpeed10m,
      required this.windDirection10m});

  factory CurrentWeatherUnits.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherUnits(
      time: json['time'],
      interval: json['interval'],
      temperature2m: json['temperature_2m'],
      relativeHumidity2m: json['relative_humidity_2m'],
      apparentTemperature: json['apparent_temperature'],
      precipitation: json['precipitation'],
      rain: json['rain'],
      snowfall: json['snowfall'],
      weatherCode: json['weather_code'],
      cloudCover: json['cloud_cover'],
      windSpeed10m: json['wind_speed_10m'],
      windDirection10m: json['wind_direction_10m'],
    );
  }

  @override
  List<Object?> get props => [
        time,
        interval,
        temperature2m,
        relativeHumidity2m,
        apparentTemperature,
        precipitation,
        rain,
        snowfall,
        weatherCode,
        cloudCover,
        windSpeed10m,
        windDirection10m
      ];
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.kebab)
class CurrentWeather with EquatableMixin {
  String time;
  int interval, relativeHumidity2m, weatherCode, cloudCover, windDirection10m;
  double temperature2m,
      apparentTemperature,
      precipitation,
      rain,
      snowfall,
      windSpeed10m;

  CurrentWeather(
      {required this.time,
      required this.interval,
      required this.temperature2m,
      required this.relativeHumidity2m,
      required this.apparentTemperature,
      required this.precipitation,
      required this.rain,
      required this.snowfall,
      required this.weatherCode,
      required this.cloudCover,
      required this.windSpeed10m,
      required this.windDirection10m});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
        time: json['time'],
        interval: json['interval'],
        temperature2m: json['temperature_2m'] as double,
        relativeHumidity2m: json['relative_humidity_2m'],
        apparentTemperature: json['apparent_temperature'],
        precipitation: json['precipitation'],
        rain: json['rain'],
        snowfall: json['snowfall'],
        weatherCode: json['weather_code'],
        cloudCover: json['cloud_cover'],
        windSpeed10m: json['wind_speed_10m'],
        windDirection10m: json['wind_direction_10m']);
  }

  @override
  List<Object?> get props => [
        time,
        interval,
        temperature2m,
        relativeHumidity2m,
        apparentTemperature,
        precipitation,
        rain,
        snowfall,
        weatherCode,
        cloudCover,
        windSpeed10m,
        windDirection10m
      ];
}
