import 'package:Weather/data/cubits/current_weather/current_weather_cubit.dart';
import 'package:Weather/data/cubits/daily_weather/daily_weather_cubit.dart';
import 'package:Weather/data/cubits/hourly_weather/hourly_weather_cubit.dart';
import 'package:Weather/data/common/geoloaction.dart';
import 'package:Weather/presentation/pages/hourly_weather.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Weather/presentation/pages/daily_weather.dart';
import 'package:Weather/presentation/pages/current_weather.dart';
import 'package:Weather/presentation/pages/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    CurrentWeather(),
    HourlyWeather(),
    DailyWeather(),
    Settings()
  ];
  String title() {
    switch (_currentIndex) {
      case 0:
        return 'currentWeather'.tr();
      case 1:
        return 'hourlyWeather'.tr();
      case 2:
        return 'dailyWeather'.tr();
      case 3:
        return 'settings'.tr();
      default:
        return '';
    }
  }

  Future<void> updateWeatherData(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('selectedLocation') != null &&
        prefs.getString('selectedLocation')!.isNotEmpty) {
      if (index == 0) {
        await context.read<CurrentWeatherCubit>().fetchCurrentWeather();
      } else if (index == 1) {
        await context.read<HourlyWeatherCubit>().fetchHourlyWeather();
      } else if (index == 2) {
        await context.read<DailyWeatherCubit>().fetchDailyWeather();
      }
    } else {
      getLocation();
    }
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title()),
        centerTitle: true,
      ),
      body: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Card(child: _pages[_currentIndex])),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            updateWeatherData(index);

            setState(() => _currentIndex = index);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.pin_drop), label: 'current'.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.av_timer), label: 'hourly'.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'daily'.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'settings'.tr()),
          ],
        ),
      ),
    );
  }
}
