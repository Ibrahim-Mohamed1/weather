import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:Weather/data/common/functions.dart';

class WorldMap extends StatefulWidget {
  final LatLng selectedLocation;
  final Function setMapLocation;
  const WorldMap(
      {super.key,
      required this.selectedLocation,
      required this.setMapLocation});

  @override
  State<WorldMap> createState() => _WorldMapState();
}

class _WorldMapState extends State<WorldMap> {
  late MapController mapControler;
  late LatLng _selectedLocation;

  @override
  void initState() {
    mapControler = MapController();
    _selectedLocation = widget.selectedLocation;
    super.initState();
  }

  @override
  void dispose() {
    mapControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapControler,
          options: MapOptions(
            backgroundColor: Colors.blue[900]!,
            initialCenter: _selectedLocation,
            onTap: (TapPosition tap, LatLng point) async {
              setState(() {
                _selectedLocation = point;
              });
              setSelectedLocation(point);
              await setCity();
              widget.setMapLocation();
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(markers: [
              Marker(
                width: 40.0,
                height: 40.0,
                point: _selectedLocation,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/Esusu.JPEG'))),
                ),
              ),
            ]),
          ],
        ),
        IconButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black26)),
            padding: EdgeInsets.zero,
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close, size: 35))
      ],
    );
  }
}
