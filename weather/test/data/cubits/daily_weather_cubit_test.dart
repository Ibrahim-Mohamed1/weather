import 'package:Weather/data/common/remote_data_source.dart';
import 'package:Weather/data/cubits/daily_weather/daily_weather_cubit.dart';
import 'package:Weather/data/cubits/daily_weather/daily_weather_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherApi extends Mock implements WeatherApi {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DailyWeatherCubit', () {
    late DailyWeatherCubit dailyWeatherCubit;
    late WeatherApi mockWeatherApi;

    setUp(() {
      mockWeatherApi = MockWeatherApi();
      dailyWeatherCubit = DailyWeatherCubit();
    });

    tearDown(() {
      dailyWeatherCubit.close();
    });

    test('initial state is DailyWeatherState.initial()', () {
      expect(dailyWeatherCubit.state, DailyWeatherState.initial());
    });

    // blocTest<DailyWeatherCubit, DailyWeatherState>(
    //   'emits [loadingStarted, loadingSuccess] when fetchDailyWeather is called',
    //   build: () {
    //     when(() => mockWeatherApi.getDailyWeatherData())
    //         .thenAnswer((_) async => testModel);
    //     return dailyWeatherCubit;
    //   },
    //   act: (cubit) => cubit.fetchDailyWeather(),
    //   expect: () => [
    //     DailyWeatherState.loadingStarted(),
    //     DailyWeatherState.loadingSuccess(testModel),
    //   ],
    // );
  });
}
