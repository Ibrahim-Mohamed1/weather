import 'package:Weather/data/common/remote_data_source.dart';
import 'package:Weather/data/cubits/hourly_weather/hourly_weather_cubit.dart';
import 'package:Weather/data/cubits/hourly_weather/hourly_weather_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherApi extends Mock implements WeatherApi {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HourlyWeatherCubit', () {
    late HourlyWeatherCubit hourlyWeatherCubit;
    late WeatherApi mockWeatherApi;

    setUp(() {
      mockWeatherApi = MockWeatherApi();
      hourlyWeatherCubit = HourlyWeatherCubit();
    });

    tearDown(() {
      hourlyWeatherCubit.close();
    });

    test('initial state is HourlyWeatherState.initial()', () {
      expect(hourlyWeatherCubit.state, HourlyWeatherState.initial());
    });

    // blocTest<HourlyWeatherCubit, HourlyWeatherState>(
    //   'emits [loadingStarted, loadingSuccess] when fetchHourlyWeather is called',
    //   build: () {
    //     when(() => mockWeatherApi.getHourlyWeatherData())
    //         .thenAnswer((_) async => testModel);
    //     return hourlyWeatherCubit;
    //   },
    //   act: (cubit) => cubit.fetchHourlyWeather(),
    //   expect: () => [
    //     HourlyWeatherState.loadingStarted(),
    //     HourlyWeatherState.loadingSuccess(testModel),
    //   ],
    // );
  });
}
