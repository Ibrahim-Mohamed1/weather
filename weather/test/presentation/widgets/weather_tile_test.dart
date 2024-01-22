import 'package:Weather/presentation/widgets/weather_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('weatherTile widget should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: weatherTile('Temperature', 25, 'temperature.png', '°C'),
        ),
      ),
    );

    expect(find.text('25°C'), findsOneWidget);
    expect(find.text('Temperature'), findsOneWidget);

    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.byType(Column), findsOneWidget);
  });
}
