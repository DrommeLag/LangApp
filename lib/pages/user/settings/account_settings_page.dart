import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/pages/templates/dialog_loading.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:lang_app/pages/templates/list_tile.dart';
import 'package:lang_app/pages/user/auth/auth_page.dart';
import 'package:lang_app/pages/user/settings/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../home/home_page.dart';

class AccountSettingsPage extends Material {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  State<Material> createState() => _AccountSettingsPage();

  static Future<String> retrievePhoto() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    final String url = await FirebaseStorage.instance
        .ref()
        .child("images")
        .child(uid!)
        .getDownloadURL();
    return url;
  }
}

class _AccountSettingsPage extends State<AccountSettingsPage> {
  late TextEditingController displayNameController;
  late TextEditingController emailController;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatNewPasswordController = TextEditingController();
  bool _showOldPassword = false;
  bool _showNewPassword = false;

  late String displayName;
  late String email;

  bool needsUpdate = false;

  bool displayNameError = false;
  bool emailError = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);

    TextStyle shadowStyle =
        theme.textTheme.labelLarge!.copyWith(color: theme.colorScheme.shadow);

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

    EdgeInsets textPadding =
        const EdgeInsets.symmetric(horizontal: 25, vertical: 5);

    Widget buildRegion(AppLocalizations local) {
      return DropDownSettingsTile(
        settingKey: SettingsPage.keyLocation,
        title: local.region,
        selected: 1,
        values: <int, String>{
          1: local.region1,
          2: local.region2,
          3: local.region3,
        },
        onChange: (region) {},
      );
    }

    void clearInputs() {
      oldPasswordController.clear();
      newPasswordController.clear();
    }

    void _changePassword(String password, String newPassword) async {
      final User? user = FirebaseAuth.instance.currentUser;
      String? email = user?.email;

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!,
          password: password,
        );

        user?.updatePassword(newPassword).then((_) {
          clearInputs();
          Navigator.of(context, rootNavigator: true).pop('dialog');
        }).catchError((error) {});
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
        } else if (e.code == 'wrong-password') {}
      }
    }

    Future<String?> openDialog() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(local.changePassword),
            content:
            Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              TextFormField(
                controller: oldPasswordController,
                obscureText: !_showOldPassword,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: local.enterOldPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showOldPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _showOldPassword = !_showOldPassword;
                      });
                    },
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 30.0)),
              TextFormField(
                controller: newPasswordController,
                obscureText: !_showNewPassword,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: local.enterNewPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _showNewPassword = !_showNewPassword;
                      });
                    },
                  ),
                ),
              ),
            ]),
            actions: [
              TextButton(
                  onPressed: () => _changePassword(
                      oldPasswordController.text,
                      newPasswordController.text),
                  child: Text(local.confirm)),
            ],
          );
        }));

    return Scaffold(
      appBar: AppBar(
        title: Text(local.profile),
        backgroundColor: const Color(0xff0A67E9),
        elevation: 0,
      ),
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
            height: 30,
            decoration: const BoxDecoration(
                gradient: backgroundGradient,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10))),
          ),
          FutureBuilder<String>(
            future: AccountSettingsPage.retrievePhoto(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text(local.loading));
              } else {
                if (snapshot.hasError) {
                  return Center(
                      child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: const Icon(Icons.person,
                              color: Colors.white, size: 100)));
                } else {
                  return Center(
                      child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                '${snapshot.data}',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ))));
                }
              }
            },
          ),
          TextButton(
              child: Text(local.uploadPhoto), onPressed: () => uploadPhoto()),
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
                textField(displayNameController, local.enterYourName,
                    displayNameError ? local.wrongYourName : null),
                const SizedBox(height: 10),
                Padding(
                    padding: textPadding,
                    child: Text(local.email, style: shadowStyle)),
                textField(emailController, local.enterEmail,
                    (emailError) ? local.wrongEmail : null),
                const SizedBox(height: 15),
                buildTile(
                    Icons.lock_outlined,
              local.changePassword,
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.5),
                    callback: () => openDialog()),
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
                    String email = Uri.encodeComponent("drommelagua@gmail.com");
                    String subject = Uri.encodeComponent("Звіт щодо помилки");
                    Uri mail = Uri.parse("mailto:$email?subject=$subject");
                    if (await launchUrl(mail)) {
                      //open email app
                    } else {
                      //don't open email app
                    }
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: MaterialButton(
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const AuthPage()),
                            (Route<dynamic> route) => false),
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

  Future uploadPhoto() async {
    final ImagePicker picker = ImagePicker();
    final storageRef = FirebaseStorage.instance.ref();
    Reference? imagesRef = storageRef.child("images");
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage == null) {
      return;
    }
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    final File imageData = (File(selectedImage.path));
    final fileRef = imagesRef.child(uid!);
    fileRef.putFile(imageData);
    AccountSettingsPage.retrievePhoto();
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
