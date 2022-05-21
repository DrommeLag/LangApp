import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/main.dart';
import 'package:lang_app/screen/user/settings/settings_page.dart';
import 'auth/auth_page.dart';

final _formKey = GlobalKey<FormState>();

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  onPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const AuthPage();
    }));
  }

  bool _isVisible = true;

  TextEditingController nameTextInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const Center(child: CircularProgressIndicator());
          }
          User? user = FirebaseAuth.instance.currentUser;
          final CollectionReference usersColection =
              FirebaseFirestore.instance.collection('users');
          final uid = user?.uid;

          return FutureBuilder<DocumentSnapshot>(
            future: usersColection.doc(uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Hello, ${data['displayName']}\n"
                            "Your email: ${data['email']}\n",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Visibility(
                          visible: _isVisible,
                          child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    'Enter name and surname below',
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    validator: (String? value) {
                                      if (value != null && value.isEmpty) {
                                        return "Please enter your name and surname:";
                                      }
                                      return null;
                                    },
                                    controller: nameTextInput,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                            Colors.green),
                                      ),
                                      child: const Text('Save',
                                        textAlign: TextAlign.center,
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (kDebugMode) {
                                            print('Update');
                                          }
                                          setState(() {
                                            InheritedDataProvider.of(context)!
                                                .databaseService
                                                .updateDisplayName(
                                                nameTextInput.text);
                                          }
                                          );
                                          //TODO add loading animation somehow
                                        }
                                      })
                                ],
                              ))),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: _isVisible ? MaterialStateProperty.all<Color>(
                                Colors.red) : null,
                          ),
                          child: Text(
                            _isVisible ? 'Cancel' : 'Edit display name',
                          ),
                          onPressed: () {
                            setState(
                                  () {
                                _isVisible = !_isVisible;
                              },
                            );
                          }),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return const SettingsPage();
                              }));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.settings),
                            Text(" Settings"),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return const AuthPage();
                              }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepOrange),
                        ),
                        child: Text(
                          "Log out",
                          style: Theme
                              .of(context)
                              .primaryTextTheme
                              .button,
                        ),
                      )
                    ]);
              }
              return const Text("Loading");
            },
          );
        });
  }
}
