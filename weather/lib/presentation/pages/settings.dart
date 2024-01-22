import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:Weather/presentation/widgets/radio_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    initializePrefs();
  }

  initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  setLocale(String lang) {
    context.setLocale(Locale(lang, 'US'));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('units'.tr(),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
            Divider(height: 2),
            RadioSetting(
                title: 'temperature'.tr(),
                preferenceKey: 'temperatureUnit',
                callback: [
                  () {},
                  () {}
                ],
                options: [
                  ['celsius'.tr(), 'Celsius'],
                  ['fahrenheit'.tr(), 'Fahrenheit']
                ]),
            Text('personal'.tr(),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
            Divider(height: 2),
            RadioSetting(
                title: 'language'.tr(),
                preferenceKey: 'language',
                callback: [
                  () {
                    setState(() {
                      context.setLocale(Locale("en", "US"));
                    });
                  },
                  () {
                    setState(() {
                      context.setLocale(Locale("es", "ES"));
                    });
                  }
                ],
                options: [
                  ['english'.tr(), 'en_US'],
                  ['spanish'.tr(), 'es_ES']
                ]),
          ],
        ),
      ),
    );
  }
}
