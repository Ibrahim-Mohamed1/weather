import 'package:Weather/data/common/functions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Weather/presentation/pages/map.dart';

void main() {
  group('Utility Functions Tests', () {
    test('toPascalCase converts sentence to PascalCase', () {
      expect(toPascalCase('hello world'), 'Hello World');
    });

    test('formatTime formats DateTime string correctly', () {
      expect(formatTime('2022-01-01T12:30:00'), '12:30 PM');
    });

    test('degreeToDirection converts degree to direction', () {
      expect(degreeToDirection(90), 'E');
    });

    test('getDayOfWeek returns correct day of the week', () {
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      print(today);
      expect(getDayOfWeek(today), 'Today');
      expect(getDayOfWeek('2024-01-22'), isNot('Monday'));
    });

    test('temperature converts temperature based on unit', () async {
      SharedPreferences.setMockInitialValues({'temperatureUnit': 'Celsius'});
      expect(temperature(25, await SharedPreferences.getInstance()), '25°C');

      SharedPreferences.setMockInitialValues({'temperatureUnit': 'Fahrenheit'});
      expect(temperature(77, await SharedPreferences.getInstance()), '171°F');
    });
  });

  group('selectLocation Test', () {
    testWidgets('selectLocation opens modal bottom sheet', (tester) async {
      SharedPreferences.setMockInitialValues(
          {'selectedLocation': '37.78929,-122.422'});

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => selectLocation(context, () {}),
            child: const Text('Open Map'),
          ),
        ),
      ));

      await tester.tap(find.text('Open Map'));
      await tester.pumpAndSettle();

      expect(find.byType(WorldMap), findsOneWidget);
    });
  });
}
