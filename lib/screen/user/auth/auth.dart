import 'package:flutter/material.dart';
import 'package:lang_app/screen/templates/input_text_field.dart';
import '../../../domain/user.dart';
import 'package:lang_app/login/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sureNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _name = '';
  String _sureName = '';
  // String _phoneNumber = '';
  String _email = '';
  String _password = '';
  bool _showLogin = true;

  final AuthService _authService = AuthService();

  void loginButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    if (_email.isEmpty || _password.isEmpty) {
      showToastErrorMessage(
          'Can`t sign you in. Please check your email/password');
      return;
    }
    MyUser? user = await _authService.signInWithEmailAndPassword(
        _email.trim(), _password.trim());
    if (user == null) {
      showToastErrorMessage(
          'Can`t sign you in. Please check your email/password');
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  void registerButtonAction() async {
    _name = _nameController.text;
    _sureName = _sureNameController.text;
    _email = _emailController.text;
    _password = _passwordController.text;

    MyUser? user;
    if (_name.isNotEmpty && _email.isNotEmpty && _password.isNotEmpty) {
      user = await _authService.registerWithEmailAndPassword(
          _name, _sureName, _email.trim(), _password.trim());
    } else {
      showToastErrorMessage(
          "Can`t register you. Please check your name/email/password");
      return;
    }

    if (user == null) {
      showToastErrorMessage(
          "Can`t register you. Please check your name/email/password");
      return;
    } else {
      _nameController.clear();
      _sureNameController.clear();
      _emailController.clear();
      _passwordController.clear();
    }
  }

  Widget formattedButton(String text, void Function() func) {
    return MaterialButton(
      height: 50,
      color: Theme.of(context).buttonTheme.colorScheme!.primary,
      onPressed: () {
        func();
      },
      child: Text(text,
          style: Theme.of(context).textTheme.button!.apply(
              color: Theme.of(context).buttonTheme.colorScheme!.onPrimary)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create your account!'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: _showLogin ? loginWidgets() : registerWidgets(),
          )),
    );
  }

  showToastErrorMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  List<Widget> registerWidgets() => <Widget>[
    InputTextField(
        icon: Icons.account_circle,
        hint: 'Name',
        controller: _nameController,
        obscure: false),
    const SizedBox(height: 20),
    InputTextField(
        icon: Icons.supervised_user_circle,
        hint: 'Surname(optional)',
        controller: _sureNameController,
        obscure: false),
    const SizedBox(height: 20),
    InputTextField(
        icon: Icons.email,
        hint: 'Email',
        controller: _emailController,
        obscure: false),
    const SizedBox(height: 20),
    InputTextField(
        icon: Icons.lock,
        hint: 'Password',
        controller: _passwordController,
        obscure: true),
    const SizedBox(height: 40),
    formattedButton('REGISTER', registerButtonAction),
    const SizedBox(height: 40),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already registered? '),
        GestureDetector(
          child: Text(
            'Login',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.apply(color: Theme.of(context).colorScheme.primary),
          ),
          onTap: () {
            setState(() {
              _showLogin = true;
            });
          },
        ),
      ],
    ),
  ];

  List<Widget> loginWidgets() => [
    InputTextField(
        icon: Icons.email,
        hint: 'Email',
        controller: _emailController,
        obscure: false),
    const SizedBox(height: 20),
    InputTextField(
        icon: Icons.lock,
        hint: 'Password',
        controller: _passwordController,
        obscure: true),
    const SizedBox(height: 40),
    formattedButton('LOGIN', loginButtonAction),
    const SizedBox(height: 40),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Not registered? '),
        GestureDetector(
          child: Text(
            'Register',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.apply(color: Theme.of(context).colorScheme.primary),
          ),
          onTap: () {
            setState(() {
              _showLogin = false;
            });
          },
        ),
      ],
    ),
  ];
}
