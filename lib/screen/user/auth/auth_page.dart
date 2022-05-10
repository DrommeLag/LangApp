import 'package:flutter/material.dart';
import 'package:lang_app/main.dart';
import 'package:lang_app/screen/main_screen.dart';
import 'package:lang_app/screen/templates/highlighted_text.dart';
import 'package:lang_app/screen/templates/input_text_field.dart';
import 'package:lang_app/screen/templates/toast_error_message.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  onClickChangeLoginRegister() {
    _showLogin = !_showLogin;
  }

  goForwardIfTrue(Future<bool>? argument) async {
    if (argument != null && await argument) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MainScreen();
      }));
    } else {
      //TODO think about if false
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sureNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showLogin = true;

  loginButtonAction(BuildContext context) {
    var _email = _emailController.text;
    var _password = _passwordController.text;
    if (_email.isNotEmpty && _password.isNotEmpty) {
      Future<bool>? result = InheritedDataProvider.of(context)
          ?.authService
          .signInWithEmailAndPassword(_email, _password);
      goForwardIfTrue(result);
    } else {
      showToastErrorMessage(
          'Can`t sign you in. Please check your email/password');
    }
  }

  registerButtonAction(BuildContext context) {
    var _name = _nameController.text;
    var _surname = _sureNameController.text;
    var _email = _emailController.text;
    var _password = _passwordController.text;

    if (_name.isNotEmpty && _email.isNotEmpty && _password.isNotEmpty) {
      var result = InheritedDataProvider.of(context)
          ?.authService
          .registerWithEmailAndPassword(_name, _surname, _email, _password);
      goForwardIfTrue(result);
    } else {
      showToastErrorMessage(
          "Can`t register you. Please check your name/email/password");
    }
  }

  Widget formattedButton(String text, Function() func) {
    return MaterialButton(
      height: 50,
      color: Theme.of(context).buttonTheme.colorScheme!.primary,
      onPressed: () => func(),
      child: Text(text,
          style: Theme.of(context).textTheme.button!.apply(
              color: Theme.of(context).buttonTheme.colorScheme!.onPrimary)),
    );
  }

  List<Widget> loginWidget(BuildContext context) {
    return [
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
      formattedButton('LOGIN', () => loginButtonAction(context)),
      const SizedBox(height: 40),
      highlightedText(
          text: 'Don\'t have account? |Register|',
          onTap: onClickChangeLoginRegister,
          highlightedStyle: Theme.of(context)
              .textTheme
              .subtitle1
              ?.apply(color: Theme.of(context).colorScheme.primary),
          textStyle: Theme.of(context).textTheme.subtitle1),
    ];
  }

  List<Widget> registerWidget(BuildContext context) {
    return <Widget>[
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
      formattedButton('REGISTER', () => registerButtonAction(context)),
      const SizedBox(height: 40),
      highlightedText(
          text: 'Already registered? |Login|',
          onTap: onClickChangeLoginRegister,
          highlightedStyle: Theme.of(context)
              .textTheme
              .subtitle1
              ?.apply(color: Theme.of(context).colorScheme.primary),
          textStyle: Theme.of(context).textTheme.subtitle1),
    ];
  }

  @override
  Widget build(BuildContext context) {
    late List<Widget> show;
    if (_showLogin) {
      show = loginWidget(context);
    } else {
      show = registerWidget(context);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create your account!'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: show,
        ),
      ),
    );
  }
}
