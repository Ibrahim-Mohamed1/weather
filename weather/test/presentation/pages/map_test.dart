import 'package:Weather/presentation/pages/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  testWidgets('WorldMap widget should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WorldMap(
          selectedLocation: LatLng(37.78929, -122.422),
          setMapLocation: () {},
        ),
      ),
    );

    expect(find.byType(FlutterMap), findsOneWidget);

    expect(find.byType(TileLayer), findsOneWidget);

    expect(find.byType(MarkerLayer), findsOneWidget);

    expect(find.byType(IconButton), findsOneWidget);
  });

  testWidgets('WorldMap onTap should update selected location',
      (WidgetTester tester) async {
    LatLng updatedLocation = LatLng(38.0, -123.0);
    Function mockSetMapLocation() {
      return () {
        updatedLocation = LatLng(38.0, -123.0);
      };
    }

    await tester.pumpWidget(
      MaterialApp(
        home: WorldMap(
          selectedLocation: LatLng(37.78929, -122.422),
          setMapLocation: mockSetMapLocation(),
        ),
      ),
    );

    await tester.tap(find.byType(FlutterMap));
    await tester.pump();

    expect(updatedLocation, LatLng(38.0, -123.0));
  });
}
