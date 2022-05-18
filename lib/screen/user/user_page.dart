import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/screen/user/settings/settings_page.dart';
import '../../core/database.dart';
import 'auth/auth_page.dart';

final _formKey = GlobalKey<FormState>();
String? _currentName;

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
                          style: Theme.of(context).primaryTextTheme.button,
                        ),
                      ),
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
                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text('Edit name and surname!'),
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
                                onChanged: (val) =>
                                    setState(() => _currentName = val),
                              ),
                              ElevatedButton(
                                  child: const Text('Save'),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      print('Update');
                                      await DatabaseService().updateDisplayName(
                                          _currentName ?? user?.displayName);
                                    }
                                    Navigator.pop(context);
                                  })
                            ],
                          ))
                    ]);
              }
              return const Text("Loading");
            },
          );
        });
  }
}
