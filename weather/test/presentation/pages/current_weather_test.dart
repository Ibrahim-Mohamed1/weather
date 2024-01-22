import 'package:Weather/data/cubits/current_weather/current_weather_cubit.dart';
import 'package:Weather/data/cubits/current_weather/current_weather_state.dart';
import 'package:Weather/presentation/pages/current_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/current_weather_model.dart';
import 'current_weather_test.mocks.dart';

@GenerateMocks([CurrentWeatherCubit])
void main() {
  late Widget testWidget;
  late MockCurrentWeatherCubit mockCurrentWeatherCubit;

  setUp(() {
    mockCurrentWeatherCubit = MockCurrentWeatherCubit();

    testWidget = BlocProvider<CurrentWeatherCubit>(
        create: (context) => mockCurrentWeatherCubit, child: CurrentWeather());
    when(mockCurrentWeatherCubit.state)
        .thenAnswer((realInvocation) => CurrentWeatherState.initial());
    when(mockCurrentWeatherCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(mockCurrentWeatherCubit.state));
    SharedPreferences.setMockInitialValues(
        {'selectedLocation': '37.78929,-122.422'});
  });

  testWidgets('Renders weather data when state is loadingSuccess',
      (WidgetTester tester) async {
    when(mockCurrentWeatherCubit.state)
        .thenReturn(CurrentWeatherState.loadingSuccess(testModel));

    await tester.pumpWidget(testWidget);

    // expect(find.text('Temperature'), findsOneWidget);
    expect(find.text('Elevation'), findsOneWidget);
  });
}
