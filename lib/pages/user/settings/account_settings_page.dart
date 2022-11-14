import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/pages/templates/dialog_loading.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:lang_app/pages/templates/list_tile.dart';
import 'package:lang_app/pages/user/settings/settings_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:url_launcher/url_launcher.dart';

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

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);

    TextStyle shadowStyle = theme
        .textTheme
        .labelLarge!
        .copyWith(color: theme.colorScheme.shadow);

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

    Widget buildRegion(AppLocalizations local) {
      return DropDownSettingsTile(
        settingKey: SettingsPage.keyLocation,
        title:local.region,
        selected: 1,
        values:<int, String>{
          1: local.region1,
          2: local.region2,
          3: local.region3,
        },
        onChange: (region) {},
      );
    }

    return Scaffold(
      floatingActionButton: Visibility(
        visible: needsUpdate,
        child: FloatingActionButton(
          onPressed: saveData,
          backgroundColor: theme.primaryColor,
          child: Icon(
            Icons.save_rounded,
            color: theme.colorScheme.secondary,
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
                    child: Text(local.yourName, style: shadowStyle)),
                textField(displayNameController,local.enterYourName,
                    displayNameError ? local.wrongYourName: null),
                const SizedBox(height: 10),
                Padding(
                    padding: textPadding,
                    child: Text(local.email, style: shadowStyle)),
                textField(emailController,local.enterEmail,
                    (emailError) ? local.wrongEmail : null),
                const SizedBox(height: 15),
                buildTile(
                    Icons.lock_outlined,
                    local.changePassword,
                    theme.primaryColor,
                    theme.primaryColor.withOpacity(0.5)),
                const SizedBox(height: 10),
                Padding(
                    padding: textPadding,
                    child: Text(local.yourPlace, style: shadowStyle)),
                buildRegion(local),
                const SizedBox(height: 10),
                buildTile(
                  Icons.bug_report,
                  local.reportBug,
                  theme.colorScheme.error,
                  theme.colorScheme.errorContainer.withOpacity(0.5),
                  callback: () async {
                    // await launchUrl(Uri.parse(
                    //     "https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley"));
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: MaterialButton(
                    onPressed: () {},
                    color: theme.colorScheme.shadow,
                    minWidth: 230,
                    textColor: theme.colorScheme.onPrimary,
                    child: Text(local.logOut),
                  ),
                ),
                Center(
                  child: MaterialButton(
                      onPressed: () {},
                      color: theme.colorScheme.errorContainer,
                      textColor: theme.colorScheme.onError,
                      minWidth: 250,
                      child: Text(local.logOutAndDelete)),
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
            .then((_) {
          indicator.pop();
          setState(() {
            displayNameError = false;
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
}
