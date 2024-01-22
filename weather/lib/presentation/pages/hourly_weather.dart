import 'dart:developer';
import 'dart:math' hide log;
import 'package:Weather/data/cubits/hourly_weather/hourly_weather_cubit.dart';
import 'package:Weather/data/cubits/hourly_weather/hourly_weather_state.dart';
import 'package:Weather/data/models/hourly_weather_model.dart';
import 'package:Weather/presentation/widgets/carousel.dart';
import 'package:Weather/presentation/widgets/weather_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Weather/data/common/functions.dart';
import 'package:Weather/data/common/remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HourlyWeather extends StatefulWidget {
  const HourlyWeather({super.key});

  @override
  State<HourlyWeather> createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeather> {
  WeatherApi weatherApi = WeatherApi();
  SharedPreferences? prefs;
  @override
  void initState() {
    _preCheck();
    super.initState();
  }

  _preCheck() async {
    prefs = await SharedPreferences.getInstance();
  }

  List vals = [
    ['temperature'.tr(), 'temperature.png'],
    ['humidity'.tr(), 'humidity.png'],
    ['windSpeed'.tr(), 'wind.png'],
    ['dewPoint'.tr(), 'dew.png'],
    ['precipitation'.tr(), 'precipitation.png'],
    ['cloudCoverage'.tr(), 'cloud coverage.png'],
    ['visibility'.tr(), 'visibility.png'],
    ['windDirection'.tr(), ''],
    ['windGust'.tr(), 'wind.png'],
    ['UVIndex'.tr(), 'uv.png']
  ];

  hourlyForecastList(HourlyWeatherData data, bool isPortrait) {
    // List<Widget> hourlyWidgets = [];
    int i = -1;
    return vals.map((e) {
      i += 1;
      return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(Random().nextInt(0xffffffff)).withOpacity(.2)),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(77, 11, 7, 7),
                        padding: const EdgeInsets.only(left: 4, right: 8),
                      ),
                      onPressed: () => selectLocation(
                          context,
                          () => setState(() => context
                              .read<HourlyWeatherCubit>()
                              .fetchHourlyWeather())),
                      child: Row(
                        children: [
                          const Icon(Icons.location_searching,
                              color: Colors.white),
                          const SizedBox(width: 10),
                          Text(
                            prefs?.getString('city') != null &&
                                    prefs!
                                        .getString('city')!
                                        .contains('Throttled')
                                ? '${data.latitude.toStringAsFixed(0)}° ${degreeToDirection(data.longitude)} ${data.longitude.toStringAsFixed(0)}° ${degreeToDirection(data.longitude)}'
                                : toPascalCase(prefs!.getString('city')!),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                  const Expanded(child: SizedBox()),
                  Text(
                    formatTime(data.hourly.time[i]),
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
              SizedBox(height: 12),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: isPortrait ? 2.5 : 3,
                crossAxisCount: isPortrait ? 2 : 3,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                children: [
                  weatherTile(
                      vals[0][0],
                      temperature(data.hourly.temperature2m[i], prefs),
                      vals[0][1],
                      ''),
                  weatherTile(vals[1][0], data.hourly.relativeHumidity[i],
                      vals[1][1], data.hourlyUnits.relativeHumidity2m),
                  weatherTile(
                      vals[2][0],
                      data.hourly.windSpeed10m[i].toStringAsFixed(0),
                      vals[2][1],
                      ' ${data.hourlyUnits.windSpeed10m}'),
                  weatherTile(
                      vals[3][0],
                      data.hourly.dewPoint2m[i].toStringAsFixed(0),
                      vals[3][1],
                      data.hourlyUnits.dewPoint2m),
                  weatherTile(
                      vals[4][0],
                      data.hourly.precipitationProbability[i],
                      vals[4][1],
                      data.hourlyUnits.precipitationProbability),
                  weatherTile(vals[5][0], data.hourly.cloudCover[i], vals[5][1],
                      data.hourlyUnits.cloudCover),
                  weatherTile(
                      vals[6][0],
                      data.hourly.visibility[i].toStringAsFixed(0),
                      vals[6][1],
                      ' ${data.hourlyUnits.visibility}'),
                  weatherTile(
                      vals[7][0],
                      degreeToDirection(data.hourly.windDirection10m[i] * 1.0),
                      '${degreeToDirection(data.hourly.windDirection10m[i] * 1.0).toLowerCase()}.png',
                      ''),
                  weatherTile(
                      vals[8][0],
                      data.hourly.windGusts10m[i].toStringAsFixed(0),
                      vals[8][1],
                      ' ${data.hourlyUnits.windGusts10m}'),
                  weatherTile(
                      vals[9][0], data.hourly.uvIndex[i], vals[9][1], '', 10),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation.name == 'portrait';

    return BlocBuilder<HourlyWeatherCubit, HourlyWeatherState>(
      builder: (context, state) {
        return state.maybeWhen(
            initial: () {
              return Container();
            },
            loadingStarted: () =>
                const Center(child: CircularProgressIndicator()),
            loadingSuccess: (data) {
              log('$data');
              return Carousel(
                scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
                children: hourlyForecastList(data, isPortrait),
                height: isPortrait ? .72 : 1.1,
              );
            },
            loadingFailed: () => Container(),
            orElse: () => Container());
      },
    );
  }
}
