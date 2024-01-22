import 'package:Weather/presentation/pages/map.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

String toPascalCase(String sentence) {
  List<String> words = sentence.split(' ');

  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      words[i] =
          words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }
  }

  return words.join(' ');
}

String formatTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate = DateFormat('h:mm a').format(dateTime);
  return formattedDate;
}

String degreeToDirection(double degree) {
  const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
  final index = ((degree % 360) / 45).round();
  return directions[index % 8];
}

setCity() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<dynamic> latLong = prefs.getString('selectedLocation')!.split(',');

  var address = await GeoCode().reverseGeocoding(
      latitude: double.parse(latLong.first),
      longitude: double.parse(latLong.last));
  await prefs.setString('city', '${address.city}');
}

setSelectedLocation(LatLng latLang) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(
      "selectedLocation", '${latLang.latitude},${latLang.longitude}');
  await setCity();
}

selectLocation(
  BuildContext context,
  Function() callback,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String>? latlang = prefs.getString('selectedLocation')?.split(',');
  showModalBottomSheet(
    clipBehavior: Clip.hardEdge,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    context: context,
    builder: (context) => FractionallySizedBox(
      heightFactor: 0.88,
      child: WorldMap(
          selectedLocation:
              LatLng(double.parse(latlang!.first), double.parse(latlang.last)),
          setMapLocation: callback),
    ),
  );
}

String getDayOfWeek(String dateString) {
  DateTime date = DateTime.parse(dateString);
  DateTime currentDate = DateTime.now();

  if (date.year == currentDate.year &&
      date.month == currentDate.month &&
      date.day == currentDate.day) {
    return 'Today';
  }

  String dayOfWeek = DateFormat('EEEE').format(date);
  return dayOfWeek;
}

String temperature(double temp, SharedPreferences? prefs) {
  String tempUnit = prefs?.getString('temperatureUnit') ?? 'Celsius';

  return tempUnit == 'Celsius'
      ? '${temp.toStringAsFixed(0)}°C'
      : ((temp * 9 / 5) + 32).toStringAsFixed(0) + '°F';
}
