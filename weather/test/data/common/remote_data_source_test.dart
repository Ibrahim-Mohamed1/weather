import 'package:Weather/data/common/remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Weather/data/models/current_weather_model.dart';
import 'package:Weather/data/models/daily_weather_model.dart';
import 'package:Weather/data/models/hourly_weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class MyMockClient extends Mock implements http.Client {
  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    return Response('', 200);
  }
}

void main() {
  group('WeatherApi Tests', () {
    late WeatherApi weatherApi;
    late MyMockClient myMockClient;

    setUp(() {
      myMockClient = MyMockClient();
      weatherApi = WeatherApi();
    });

    test('getCurrentWeatherData success', () async {
      when(myMockClient.get(Uri.parse(''), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('{}', 200));
      final result = await weatherApi.getCurrentWeatherData();
      expect(result, isA<CurrentWeatherData>());
    });

    test('getCurrentWeatherData failure', () async {
      when(myMockClient.get(Uri(), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Error', 404));
      expect(() => weatherApi.getCurrentWeatherData(), throwsException);
    });

    test('getHourlyWeatherData success', () async {
      when(myMockClient.get(Uri(), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('{}', 200));
      final result = await weatherApi.getHourlyWeatherData();
      expect(result, isA<HourlyWeatherData>());
    });

    test('getHourlyWeatherData failure', () async {
      when(myMockClient.get(Uri(), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Error', 404));
      expect(() => weatherApi.getHourlyWeatherData(), throwsException);
    });

    test('getDailyWeatherData success', () async {
      when(myMockClient.get(Uri(), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('{}', 200));
      final result = await weatherApi.getDailyWeatherData();
      expect(result, isA<DailyWeatherData>());
    });

    test('getDailyWeatherData failure', () async {
      when(myMockClient.get(Uri(), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Error', 404));
      expect(() => weatherApi.getDailyWeatherData(), throwsException);
    });
  });
}
