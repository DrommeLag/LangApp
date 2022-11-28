import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/pages/templates/dialog_loading.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:lang_app/pages/templates/list_tile.dart';
import 'package:lang_app/pages/templates/material_push_template.dart';
import 'package:lang_app/pages/user/auth/auth_page.dart';
import 'package:lang_app/pages/user/settings/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../templates/input_text_field.dart';

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

  late String displayName;
  late String email;

  bool needsUpdate = false;

  bool displayNameError = false;
  bool emailError = false;

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

    EdgeInsets textPadding =
        const EdgeInsets.symmetric(horizontal: 25, vertical: 5);

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

    void clearInputs() {
      oldPasswordController.clear();
      newPasswordController.clear();
    }

    void _changePassword(String password, String newPassword) async {
      final User? user = FirebaseAuth.instance.currentUser;
      String? email = user?.email;

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!,
          password: password,
        );

        user?.updatePassword(newPassword).then((_) {
          print("Successfully changed password");
          clearInputs();
          Navigator.of(context, rootNavigator: true).pop('dialog');
        }).catchError((error) {
          print("Password can't be changed $error");
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }

    Future<String?> openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Змінити пароль'),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                TextField(
                  controller: oldPasswordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Введіть старий пароль'),
                ),
                Padding(padding: EdgeInsets.only(bottom: 30.0)),
                TextField(
                  controller: newPasswordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Введіть новий пароль'),
                ),
              ]),
              actions: [
                TextButton(
                    onPressed: () => _changePassword(
                        oldPasswordController.text, newPasswordController.text),
                    child: const Text('Підтвердити')),
              ],
            ));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Профіль"),
        backgroundColor: const Color(0xff0A67E9),
        elevation: 0,
      ),
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
                return const Center(child: Text('Please wait its loading...'));
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
              child: const Text('Upload Photo'),
              onPressed: () => uploadPhoto()),
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
                    child: Text("Ваше ім'я:", style: shadowStyle)),
                textField(displayNameController, "Введіть ваше ім'я",
                    displayNameError ? "Неправильне ім'я" : null),
                const SizedBox(height: 10),
                Padding(
                    padding: textPadding,
                    child: Text('Електронна пошта: ', style: shadowStyle)),
                textField(emailController, 'Введіть вашу електронну пошту',
                    (emailError) ? 'Неправильна пошта' : null),
                const SizedBox(height: 15),
                buildTile(
                    Icons.lock_outlined,
                    'Змінити пароль',
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.5),
                    callback: () => openDialog()),
                const SizedBox(height: 10),
                Padding(
                    padding: textPadding,
                    child: Text('Ваше місце', style: shadowStyle)),
                buildRegion(context),
                const SizedBox(height: 10),
                buildTile(
                  Icons.bug_report,
                  'Повідомити про помилку',
                  Theme.of(context).colorScheme.error,
                  Theme.of(context).colorScheme.errorContainer.withOpacity(0.5),
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
                    color: Theme.of(context).colorScheme.shadow,
                    minWidth: 230,
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    child: const Text('Вийти'),
                  ),
                ),
                Center(
                  child: MaterialButton(
                      onPressed: () {},
                      color: Theme.of(context).colorScheme.errorContainer,
                      textColor: Theme.of(context).colorScheme.onError,
                      minWidth: 250,
                      child: const Text('Видалити акаунт та вийти')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future uploadPhoto() async {
    final ImagePicker _picker = ImagePicker();
    final storageRef = FirebaseStorage.instance.ref();
    Reference? imagesRef = storageRef.child("images");
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage == null) {
      return;
    }
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    final File imageData = (File(selectedImage.path));
    final fileRef = imagesRef.child(uid!);
    final uploadTask = fileRef.putFile(imageData);
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
