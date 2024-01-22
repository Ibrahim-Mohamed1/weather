import 'dart:math';

import 'package:Weather/data/cubits/current_weather/current_weather_cubit.dart';
import 'package:Weather/data/cubits/current_weather/current_weather_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Weather/data/common/functions.dart';
import 'package:Weather/data/common/geoloaction.dart';
import 'package:Weather/data/common/remote_data_source.dart';
import 'package:Weather/presentation/widgets/weather_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({super.key});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

@override
class _CurrentWeatherState extends State<CurrentWeather> {
  WeatherApi weatherApi = WeatherApi();
  SharedPreferences? prefs;

  @override
  void initState() {
    initializeSharedPrefs();
    super.initState();
  }

  initializeSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  List vals = [
    ['elevation'.tr(), 'elevation.png'],
    ['windSpeed'.tr(), 'wind.png'],
    ['humidity'.tr(), 'humidity.png'],
    ['precipitation'.tr(), 'precipitation.png'],
    ['rain'.tr(), 'rain.png'],
    ['snow'.tr(), 'snow.png'],
    ['windDirection'.tr(), ''],
    ['cloudCoverage'.tr(), 'cloud coverage.png']
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
      builder: (context, state) {
        bool isPortrait = MediaQuery.of(context).orientation.name == 'portrait';
        return state.maybeWhen(
            initial: () {
              getLocation();
              print(prefs?.getString('selectedLocation'));
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          getLocation();
                          if (prefs!.getString('selectedLocation') != null &&
                              prefs!
                                  .getString('selectedLocation')!
                                  .isNotEmpty) {
                            await context
                                .read<CurrentWeatherCubit>()
                                .fetchCurrentWeather();
                          }
                        },
                        child: Text('useMyLocation'.tr())),
                  ],
                ),
              );
            },
            loadingStarted: () =>
                const Center(child: CircularProgressIndicator()),
            loadingSuccess: (data) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(Random().nextInt(0xffffffff)).withOpacity(.2),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SingleChildScrollView(
                  primary: true,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(77, 11, 7, 7),
                                padding:
                                    const EdgeInsets.only(left: 4, right: 8),
                              ),
                              onPressed: () => selectLocation(context, () {
                                    setState(() {
                                      context
                                          .read<CurrentWeatherCubit>()
                                          .fetchCurrentWeather();
                                    });
                                  }),
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
                                        : toPascalCase(
                                            prefs!.getString('city')!),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          const Expanded(child: SizedBox()),
                          Text(formatTime(data.current.time))
                        ],
                      ),
                      Text(
                        temperature(data.current.temperature2m, prefs),
                        style: const TextStyle(fontSize: 60),
                      ),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        childAspectRatio: isPortrait ? 1.6 : 3,
                        crossAxisCount: isPortrait ? 2 : 4,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        children: [
                          weatherTile(
                              vals[0][0],
                              data.elevation.toStringAsFixed(0),
                              vals[0][1],
                              ' m'),
                          weatherTile(
                              vals[1][0],
                              data.current.windSpeed10m.toStringAsFixed(0),
                              vals[1][1],
                              ' ${data.currentUnits.windSpeed10m}'),
                          weatherTile(
                              vals[2][0],
                              data.current.relativeHumidity2m,
                              vals[2][1],
                              data.currentUnits.relativeHumidity2m),
                          weatherTile(
                              vals[3][0],
                              data.current.precipitation,
                              vals[3][1],
                              ' ${data.currentUnits.precipitation}'),
                          weatherTile(vals[4][0], data.current.rain, vals[4][1],
                              ' ${data.currentUnits.rain}'),
                          weatherTile(vals[5][0], data.current.snowfall,
                              vals[5][1], ' ${data.currentUnits.snowfall}'),
                          weatherTile(
                              vals[6][0],
                              degreeToDirection(double.parse(
                                  "${data.current.windDirection10m}")),
                              '${degreeToDirection(data.current.windDirection10m * 1.0).toLowerCase()}.png',
                              ''),
                          weatherTile(vals[7][0], data.current.cloudCover,
                              vals[7][1], data.currentUnits.cloudCover),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            loadingFailed: () => Container(),
            orElse: () => Container());
      },
    );
  }
}
