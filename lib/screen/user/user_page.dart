import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/core/inherit_provider.dart';
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

  var page = StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return const Center(child: CircularProgressIndicator());
        }
        User? user = FirebaseAuth.instance.currentUser;
        final uid = user?.uid;

        final CollectionReference usersColection =
            FirebaseFirestore.instance.collection('users');

        return FutureBuilder<DocumentSnapshot>(
          future: usersColection.doc(uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.deepOrange),
                      ),
                      // color: Theme.of(context).primaryColor,
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
                    )
                  ]);
            }
            return const CircularProgressIndicator();
          },
        );
      });

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
                          child: const Text('Edit display name'),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChangeName()),
                            );
                            if (result) {
                              setState(() {});
                            }
                          }),
                      ElevatedButton(
                          child: const Text('Change password'),
                          onPressed: () {
                            setState(
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangePassword()),
                                );
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
                            Text("Settings"),
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
                          style: Theme.of(context).primaryTextTheme.button,
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

class ChangeName extends StatefulWidget {
  const ChangeName({Key? key}) : super(key: key);

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  TextEditingController nameTextInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Change name'),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return "Please enter your name and surname";
                    }
                    return null;
                  },
                  controller: nameTextInput,
                  decoration: const InputDecoration(
                    labelText: 'Name and surname',
                    hintText: 'Enter your name and surname',
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: const Text(
                      'Save',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (kDebugMode) {
                          print('Update');
                        }
                        setState(() {
                          InheritedDataProvider.of(context)!
                              .authService
                              .updateDisplayName(nameTextInput.text);
                        });
                        Navigator.pop(context, true);
                      }
                    })
              ],
            )));
  }
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var _passwordVisible = false;
  TextEditingController passwordTextInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Change password'),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return "Please enter your new password";
                    }
                    return null;
                  },
                  controller: passwordTextInput,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: const Text(
                      'Save',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (kDebugMode) {
                          print('Update');
                        }
                        setState(() {
                          FirebaseAuth.instance.currentUser
                              ?.updatePassword(passwordTextInput.text);
                        });
                        Navigator.pop(context);
                      }
                    })
              ],
            )));
  }
}
