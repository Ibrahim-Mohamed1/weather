import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:Weather/data/common/functions.dart';

Future<String> getLocation({Function? callback}) async {
  bool locationEnabled = await Geolocator.isLocationServiceEnabled();

  if (!locationEnabled) {
    throw Exception("Location disabled");
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Permission denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    throw Exception('Permission denied forever');
  }

  var location = await Geolocator.getCurrentPosition();

  setSelectedLocation(LatLng(location.latitude, location.longitude));
  return '${location.latitude},${location.longitude}';
}
