import 'dart:math';

import 'package:Weather/data/common/functions.dart';
import 'package:Weather/data/cubits/daily_weather/daily_weather_cubit.dart';
import 'package:Weather/data/cubits/daily_weather/daily_weather_state.dart';
import 'package:Weather/data/models/daily_weather_model.dart';
import 'package:Weather/presentation/widgets/carousel.dart';
import 'package:Weather/presentation/widgets/weather_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Weather/data/common/remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyWeather extends StatefulWidget {
  const DailyWeather({super.key});

  @override
  State<DailyWeather> createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
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

  List atts = [
    ['sunrise'.tr(), 'sunrise.png'],
    ['sunset'.tr(), 'sunset.png'],
    ['maxUV'.tr(), 'uv.png'],
    ['precipitationSum'.tr(), 'precipitation.png'],
    ['maxWindSpeed'.tr(), 'wind.png'],
    ['precipitationOdds'.tr(), 'precipitation.png'],
  ];

  createSlides(DailyWeatherData data, List atts, bool isPortrait) {
    int i = -1;
    return atts.map(
      (e) {
        i += 1;
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(Random().nextInt(0xffffffff)).withOpacity(.2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(77, 11, 7, 7),
                          padding: const EdgeInsets.only(left: 4, right: 8),
                        ),
                        onPressed: () => selectLocation(context, () {
                              setState(() {
                                context
                                    .read<DailyWeatherCubit>()
                                    .fetchDailyWeather();
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
                                  : toPascalCase(prefs!.getString('city')!),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                    const Expanded(child: SizedBox()),
                    Text(
                      getDayOfWeek(data.daily.time[i]).toLowerCase().tr(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34),
                  child: Row(
                    mainAxisAlignment: isPortrait
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'low'.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        'high'.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(temperature(data.daily.temperature2mMin[i], prefs),
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(8, 4, 8, 0),
                          height: 12,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.red])),
                        ),
                      ),
                      Text(
                        temperature(data.daily.temperature2mMax[i], prefs),
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: isPortrait ? 1 : 3,
                  crossAxisCount: isPortrait ? 2 : 3,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  children: [
                    weatherTile(atts[0][0], formatTime(data.daily.sunrise[i]),
                        atts[0][1], ''),
                    weatherTile(atts[1][0], formatTime(data.daily.sunset[i]),
                        atts[1][1], ''),
                    weatherTile(
                        atts[2][0],
                        data.daily.uvIndexMax[i].toStringAsFixed(1),
                        atts[2][1],
                        '',
                        10),
                    weatherTile(
                      atts[3][0],
                      data.daily.precipitationSum[i],
                      atts[3][1],
                      ' ${data.dailyUnits.precipitationSum}',
                    ),
                    weatherTile(
                        atts[4][0],
                        data.daily.windSpeed10mMax[i].toStringAsFixed(0),
                        atts[4][1],
                        ' ${data.dailyUnits.windSpeed10mMax}'),
                    weatherTile(
                        atts[5][0],
                        data.daily.precipitationProbabilityMax[i],
                        atts[5][1],
                        '%'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation.name == 'portrait';

    return BlocBuilder<DailyWeatherCubit, DailyWeatherState>(
      builder: (context, state) {
        return state.maybeWhen(
            initial: () {
              return Center();
            },
            loadingStarted: () =>
                const Center(child: CircularProgressIndicator()),
            loadingSuccess: (success) {
              return Carousel(
                height: isPortrait ? 0.72 : 0.74,
                children: createSlides(success, atts, isPortrait),
              );
            },
            loadingFailed: () => Container(),
            orElse: () => Container());
      },
    );
  }
}
