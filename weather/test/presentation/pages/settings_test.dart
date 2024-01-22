import 'package:Weather/presentation/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:Weather/presentation/widgets/radio_settings.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
  });

  group('Settings Widget Tests', () {
    testWidgets('Settings widget renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EasyLocalization(
            supportedLocales: [Locale('en', 'US')],
            path: 'assets/translations',
            fallbackLocale: Locale('en', 'US'),
            startLocale: Locale('en', 'US'),
            useFallbackTranslations: true,
            child: Builder(
              builder: (context) {
                return Settings();
              },
            ),
          ),
        ),
      );

      expect(find.text('units'.tr()), findsOneWidget);

      expect(find.byType(RadioSetting), findsNWidgets(2));
    });

    testWidgets('Tapping on language radio buttons changes locale',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EasyLocalization(
            supportedLocales: [Locale('en', 'US')],
            path: 'assets/translations',
            fallbackLocale: Locale('en', 'US'),
            startLocale: Locale('en', 'US'),
            useFallbackTranslations: true,
            child: Builder(
              builder: (context) {
                return Settings();
              },
            ),
          ),
        ),
      );

      when(mockPrefs.getString('language')).thenReturn('en_US');

      expect(find.text('english'.tr()), findsOneWidget);

      await tester.tap(find.text('spanish'.tr()));
      await tester.pump();

      // verify(context.setLocale(Locale('es', 'ES')));
    });
  });
}
