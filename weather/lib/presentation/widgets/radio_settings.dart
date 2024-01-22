import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RadioSetting extends StatefulWidget {
  final List<List> options;
  final String title, preferenceKey;
  final List<Function()> callback;
  const RadioSetting(
      {super.key,
      required this.options,
      required this.title,
      required this.preferenceKey,
      required this.callback});

  @override
  State<RadioSetting> createState() => _RadioSettingState();
}

class _RadioSettingState extends State<RadioSetting> {
  String? _selectedValue;
  @override
  void initState() {
    _loadPrefs();
    super.initState();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedValue =
          prefs.getString(widget.preferenceKey) ?? widget.options.first.last;
    });
  }

  Future<void> _savePrefs(String value) async {
    final prefs = await SharedPreferences.getInstance();
    print(value);
    prefs.setString(widget.preferenceKey, value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.title),
        const Expanded(child: SizedBox()),
        ...List.generate(
            widget.options.length,
            (index) => Row(
                  children: [
                    Radio(
                      value: widget.options[index][1],
                      groupValue: _selectedValue,
                      onChanged: (i) {
                        setState(() {
                          _selectedValue = i;
                          _savePrefs(i);
                        });
                        widget.callback[index]();
                      },
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedValue = widget.options[index][1];
                            _savePrefs(widget.options[index][1]);
                          });
                          widget.callback[index]();
                        },
                        child: Text(widget.options[index][0])),
                  ],
                )),
      ],
    );
  }
}
