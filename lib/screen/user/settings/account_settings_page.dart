import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/core/inherit_provider.dart';
import 'package:lang_app/screen/templates/gradients.dart';
import 'package:lang_app/screen/templates/input_text_field.dart';
import 'package:lang_app/screen/templates/list_tile.dart';
import 'package:lang_app/screen/user/settings/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountSettingsPage extends Material {
  @override
  State<Material> createState() => _AccountSettingsPage();
}

class _AccountSettingsPage extends State<AccountSettingsPage> {
  late TextEditingController displayNameController;

  late TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    TextStyle shadowStyle = Theme.of(context)
        .textTheme
        .labelLarge!
        .copyWith(color: Theme.of(context).colorScheme.shadow);

    Widget textField(TextEditingController controller, String hint) {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 3),
            )),
      );
    }

    EdgeInsets textPadding = EdgeInsets.symmetric(horizontal: 25, vertical: 5);

    Widget buildRegion(BuildContext context) {
      return DropDownSettingsTile(
        settingKey: SettingsPage.keyLocation,
        title: "Регіон",
        selected: 1,
        values: const <int, String>{
          1: "Чернівецька обл.",
          2: "Львівська обл.",
          3: "Київська обл.",
        },
        onChange: (region) {},
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(
                gradient: backgroundGradient,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                Padding(
                    padding: textPadding,
                    child: Text('Display Name', style: shadowStyle)),
                textField(displayNameController, 'Enter display name'),
                SizedBox(height: 10),
                Padding(
                    padding: textPadding,
                    child: Text('Email: ', style: shadowStyle)),
                textField(emailController, 'Enter email'),
                SizedBox(height: 15),
                buildTile(
                    Icons.lock_outlined,
                    'Change password',
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColorLight),
                SizedBox(height: 10),
                Padding(
                    padding: textPadding,
                    child: Text('Your place', style: shadowStyle)),
                buildRegion(context),
                SizedBox(height: 10),
                buildTile(
                  Icons.bug_report,
                  'Report bug',
                  Theme.of(context).colorScheme.error,
                  Theme.of(context).colorScheme.errorContainer.withOpacity(0.5),
                  callback: () async {
                    await launchUrl(Uri.parse(
                        "https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley"));
                  },
                ),
                SizedBox(height: 30),
                Center(child: MaterialButton(
                  onPressed: () {},
                  color: Theme.of(context).colorScheme.shadow,
                  minWidth: 230,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  child: Text('Exit'),),),
                Center(child: MaterialButton(onPressed: (){},
                color:Theme.of(context).colorScheme.errorContainer,
                textColor: Theme.of(context).colorScheme.onError,
                minWidth: 250,
                child: Text('Delete and exit')),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    User user = InheritedDataProvider.of(context)!.authService.getUser();
    displayNameController = TextEditingController(text: user.displayName);
    emailController = TextEditingController(text: user.email);
  }
}
