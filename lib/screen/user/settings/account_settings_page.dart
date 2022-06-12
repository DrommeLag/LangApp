import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/screen/templates/dialog_loading.dart';
import 'package:lang_app/screen/templates/gradients.dart';
import 'package:lang_app/screen/templates/list_tile.dart';
import 'package:lang_app/screen/user/settings/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountSettingsPage extends Material {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  State<Material> createState() => _AccountSettingsPage();
}

class _AccountSettingsPage extends State<AccountSettingsPage> {
  late TextEditingController displayNameController;

  late TextEditingController emailController;

  late String displayName;
  late String email;

  bool needsUpdate = false;

  bool displayNameError = false;
  bool emailError = false;

  onEditingDone() {
    if (displayName != displayNameController.text ||
        email != emailController.text) {
      setState(() {
        needsUpdate = true;
      });
    } else {
      setState(() {
        needsUpdate = false;
      });
    }
  }

  saveData() async {
    DialogLoadingIndicator indicator = DialogLoadingIndicator(context);

    if (displayName != displayNameController.text) {
      if (displayNameController.text.isEmpty) {
        indicator.pop();
        setState(() {
          displayNameError = true;
        });
      } else {
        await AuthService()
            .updateDisplayName(displayNameController.text)
            .then((value) {
          indicator.pop();
          setState(() {
            displayNameError = !value;
          });
        });
      }
    }

    if (email != emailController.text) {
      if (emailController.text.isEmpty) {
        indicator.pop();
        setState(() {
          emailError = true;
        });
      } else {
        await AuthService().updateEmail(emailController.text).then((value) {
          indicator.pop();
          setState(() {
            emailError = !value;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle shadowStyle = Theme.of(context)
        .textTheme
        .labelLarge!
        .copyWith(color: Theme.of(context).colorScheme.shadow);

    Widget textField(
        TextEditingController controller, String hint, String? errorText) {
      return TextField(
        onChanged: (_) => onEditingDone(),
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 3),
            )),
      );
    }

    EdgeInsets textPadding = const EdgeInsets.symmetric(horizontal: 25, vertical: 5);

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
      floatingActionButton: Visibility(
        visible: needsUpdate,
        child: FloatingActionButton(
          onPressed: saveData,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.save_rounded,
            color: Theme.of(context).colorScheme.secondary,
            size: 24,
          ),
        ),
      ),
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
                const SizedBox(height: 10),
                Padding(
                    padding: textPadding,
                    child: Text('Display Name:', style: shadowStyle)),
                textField(displayNameController, 'Enter display name',
                    displayNameError ? 'Invalid name' : null),
                const SizedBox(height: 10),
                Padding(
                    padding: textPadding,
                    child: Text('Email: ', style: shadowStyle)),
                textField(emailController, 'Enter email',
                    (emailError) ? 'Invalid email' : null),
                const SizedBox(height: 15),
                buildTile(
                    Icons.lock_outlined,
                    'Change password',
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColorLight),
                const SizedBox(height: 10),
                Padding(
                    padding: textPadding,
                    child: Text('Your place', style: shadowStyle)),
                buildRegion(context),
                const SizedBox(height: 10),
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
                const SizedBox(height: 30),
                Center(
                  child: MaterialButton(
                    onPressed: () {},
                    color: Theme.of(context).colorScheme.shadow,
                    minWidth: 230,
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    child: const Text('Exit'),
                  ),
                ),
                Center(
                  child: MaterialButton(
                      onPressed: () {},
                      color: Theme.of(context).colorScheme.errorContainer,
                      textColor: Theme.of(context).colorScheme.onError,
                      minWidth: 250,
                      child: const Text('Delete and exit')),
                )
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

    User user = AuthService().getUser();
    displayName = user.displayName!;
    email = user.email!;

    displayNameController = TextEditingController(text: displayName);
    emailController = TextEditingController(text: email);
  }
}
