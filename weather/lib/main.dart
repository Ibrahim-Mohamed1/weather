import 'package:Weather/data/cubits/current_weather/current_weather_cubit.dart';
import 'package:Weather/data/cubits/daily_weather/daily_weather_cubit.dart';
import 'package:Weather/data/cubits/hourly_weather/hourly_weather_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Weather/presentation/app.dart';
import 'package:Weather/data/common/theming.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('es', 'ES')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: WeatherApp()));
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CurrentWeatherCubit()),
        BlocProvider(create: (context) => HourlyWeatherCubit()),
        BlocProvider(create: (context) => DailyWeatherCubit())
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Weather',
        theme: weatherAppTheme,
        home: const MyHomePage(),
      ),
    );
  }
}
