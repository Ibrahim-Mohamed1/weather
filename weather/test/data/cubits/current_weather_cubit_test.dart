import 'package:Weather/data/common/remote_data_source.dart';
import 'package:Weather/data/cubits/current_weather/current_weather_cubit.dart';
import 'package:Weather/data/cubits/current_weather/current_weather_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherApi extends Mock implements WeatherApi {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CurrentWeatherCubit', () {
    late CurrentWeatherCubit currentWeatherCubit;
    late WeatherApi mockWeatherApi;

    setUp(() {
      mockWeatherApi = MockWeatherApi();
      currentWeatherCubit = CurrentWeatherCubit();
    });

    tearDown(() {
      currentWeatherCubit.close();
    });

    test('initial state is CurrentWeatherState.initial()', () {
      expect(currentWeatherCubit.state, CurrentWeatherState.initial());
    });

    // blocTest<CurrentWeatherCubit, CurrentWeatherState>(
    //   'emits [loadingStarted, loadingSuccess] when fetchCurrentWeather is called',
    //   build: () {
    //     when(() => mockWeatherApi.getCurrentWeatherData())
    //         .thenAnswer((_) async => testModel);
    //     return currentWeatherCubit;
    //   },
    //   act: (cubit) => cubit.fetchCurrentWeather(),
    //   expect: () => [
    //     CurrentWeatherState.loadingStarted(),
    //     CurrentWeatherState.loadingSuccess(testModel),
    //   ],
    // );
  });
}
