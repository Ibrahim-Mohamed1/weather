import 'package:Weather/presentation/widgets/radio_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('RadioSetting widget should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RadioSetting(
            options: [
              ['Option 1', 'option1'],
              ['Option 2', 'option2'],
              ['Option 3', 'option3'],
            ],
            title: 'Test Title',
            preferenceKey: 'testKey',
            callback: [() {}, () {}, () {}],
          ),
        ),
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Option 1'), findsOneWidget);
    expect(find.text('Option 2'), findsOneWidget);
    expect(find.text('Option 3'), findsOneWidget);

    await tester.tap(find.text('Option 1'));
    await tester.pump();

    expect(find.byType(Radio), findsNWidgets(3));
    expect(find.byType(GestureDetector), findsNWidgets(6));
  });
}
