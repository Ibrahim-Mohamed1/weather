import 'dart:convert';
import 'dart:developer';
import 'package:Weather/data/models/current_weather_model.dart';
import 'package:Weather/data/models/daily_weather_model.dart';
import 'package:Weather/data/models/hourly_weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeatherApi {
  final String baseUrl = 'https://api.open-meteo.com/v1/forecast';
  WeatherApi();
  Future<CurrentWeatherData> getCurrentWeatherData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> latLong = prefs.getString('selectedLocation')!.split(',');
    final response = await http.get(Uri.parse(
        '$baseUrl?latitude=${latLong.first}&longitude=${latLong.last}&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,rain,snowfall,weather_code,cloud_cover,wind_speed_10m,wind_direction_10m&timezone=auto'));

    if (response.statusCode == 200) {
      return CurrentWeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<HourlyWeatherData> getHourlyWeatherData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> latLong = prefs.getString('selectedLocation')!.split(',');

    final response = await http.get(Uri.parse(
        '$baseUrl?latitude=${latLong.first}&longitude=${latLong.last}&hourly=temperature_2m,uv_index,relative_humidity_2m,dew_point_2m,precipitation_probability,cloud_cover,visibility,wind_speed_10m,wind_direction_10m,wind_gusts_10m,temperature_80m&timezone=auto'));

    if (response.statusCode == 200) {
      log('HOURLY: ${json.decode(response.body)['hourly_units'][0]}');
      return HourlyWeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<DailyWeatherData> getDailyWeatherData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> latLong = prefs.getString('selectedLocation')!.split(',');

    final response = await http.get(Uri.parse(
        '$baseUrl?latitude=${latLong.first}&longitude=${latLong.last}&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset,uv_index_max,precipitation_sum,wind_speed_10m_max,precipitation_probability_max&timezone=auto'));

    if (response.statusCode == 200) {
      log('DAILY: ${response.body}');
      return DailyWeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
