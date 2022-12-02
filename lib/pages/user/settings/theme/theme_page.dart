import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  static const keyDarkMode = "key-dark-mode";

  @override
  State<StatefulWidget> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Змінити тему"),
          //backgroundColor: Colors.orangeAccent,
        ),
        body: SafeArea(
            child: SettingsGroup(title: "Вигляд", children: [
              buildThemeSetting()
            ]),
        )
    );
  }

  Widget buildThemeSetting() {
    return RadioSettingsTile(
        title: 'Тема додатку',
        settingKey: ThemePage.keyDarkMode,
        selected: Settings.getValue(ThemePage.keyDarkMode,
            defaultValue: ThemeMode.system.index)!,
        values: <int, String>{
          ThemeMode.system.index: 'Тема системи',
          ThemeMode.dark.index: 'Темна тема',
          ThemeMode.light.index: 'Світла тема',
        });
  }
}
