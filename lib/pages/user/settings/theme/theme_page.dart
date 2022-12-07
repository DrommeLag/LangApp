import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  static const keyDarkMode = "key-dark-mode";

  @override
  State<StatefulWidget> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(local.changeTheme),
          //backgroundColor: Colors.orangeAccent,
        ),
        body: SafeArea(
            child: SettingsGroup(title: local.apperience, children: [
              buildThemeSetting(local)
            ]),
        )
    );
  }

  Widget buildThemeSetting(AppLocalizations local) {
    return RadioSettingsTile(
        title: local.chooseTheme,
        settingKey: ThemePage.keyDarkMode,
        selected: Settings.getValue(ThemePage.keyDarkMode,
            defaultValue: ThemeMode.system.index)!,
        values: <int, String>{
          ThemeMode.system.index: local.systemTheme,
          ThemeMode.dark.index: local.darkTheme,
          ThemeMode.light.index: local.lightTheme,
        });
  }
}
