import 'package:Weather/data/cubits/hourly_weather/hourly_weather_cubit.dart';
import 'package:Weather/presentation/pages/hourly_weather.dart';
import 'package:Weather/presentation/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Weather/data/models/hourly_weather_model.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([HourlyWeatherCubit])
void main() {
  testWidgets('Hourly widget should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HourlyWeather(),
      ),
    );

    expect(find.byType(Hourly), findsOneWidget);

    expect(find.byType(Container), findsOneWidget);
  });

  testWidgets('Hourly loading started should display CircularProgressIndicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HourlyWeather(),
      ),
    );

    // context.read<HourlyWeatherCubit>().emit(HourlyWeatherState.loadingStarted());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Hourly loading success should display Carousel',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: HourlyWeather(),
      ),
    );

    final hourlyWeatherData = HourlyWeatherData.fromJson({});

    // context.read<HourlyWeatherCubit>().emit(HourlyWeatherState.loadingSuccess(hourlyWeatherData));

    expect(find.byType(Carousel), findsOneWidget);
  });
}
