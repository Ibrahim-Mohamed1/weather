import 'package:Weather/data/cubits/daily_weather/daily_weather_cubit.dart';
import 'package:Weather/presentation/pages/daily_weather.dart';
import 'package:Weather/presentation/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Weather/data/models/daily_weather_model.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([DailyWeatherCubit])
void main() {
  testWidgets('DailyWeather widget should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DailyWeather(),
      ),
    );

    expect(find.byType(DailyWeather), findsOneWidget);

    expect(find.byType(Center), findsOneWidget);
  });

  testWidgets(
      'DailyWeather loading started should display CircularProgressIndicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DailyWeather(),
      ),
    );

    // context.read<DailyWeatherCubit>().emit(DailyWeatherState.loadingStarted());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('DailyWeather loading success should display Carousel',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: DailyWeather(),
      ),
    );

    // Sample data
    final dailyWeatherData = DailyWeatherData.fromJson({
      // Add your sample data here
    });

    // Set the state to loadingSuccess with sample data
    // context
    //     .read<DailyWeatherCubit>()
    //     .emit(DailyWeatherState.loadingSuccess(dailyWeatherData));

    // Verify if Carousel is present
    expect(find.byType(Carousel), findsOneWidget);
  });
}
