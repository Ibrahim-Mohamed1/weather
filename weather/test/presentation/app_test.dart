import 'package:Weather/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Weather/data/cubits/current_weather/current_weather_cubit.dart';
import 'package:Weather/data/cubits/daily_weather/daily_weather_cubit.dart';
import 'package:Weather/data/cubits/hourly_weather/hourly_weather_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('MyHomePage Widget Tests', () {
    late SharedPreferences prefs;

    setUp(() async {
      prefs = await SharedPreferences.getInstance();
    });

    testWidgets('MyHomePage widget should render correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MyHomePage(),
        ),
      );

      expect(find.byType(MyHomePage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('MyHomePage updateWeatherData should update weather data',
        (WidgetTester tester) async {
      final currentWeatherCubit = CurrentWeatherCubit();
      final hourlyWeatherCubit = HourlyWeatherCubit();
      final dailyWeatherCubit = DailyWeatherCubit();

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<CurrentWeatherCubit>.value(
                  value: currentWeatherCubit),
              BlocProvider<HourlyWeatherCubit>.value(value: hourlyWeatherCubit),
              BlocProvider<DailyWeatherCubit>.value(value: dailyWeatherCubit),
            ],
            child: MyHomePage(),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.av_timer));
      await tester.pumpAndSettle();

      // expect(hourlyWeatherCubit.state, isA<CurrentWeatherState.initial()>());
      // expect(currentWeatherCubit.state, isA<CurrentWeatherState.loadingStarted()>());
      // expect(dailyWeatherCubit.state, isA<CurrentWeatherState.loadingSuccess(success)>());
    });
  });
}
