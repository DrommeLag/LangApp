import 'package:flutter/material.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/core/database_service.dart';
import 'package:lang_app/pages/main_screen.dart';
import 'package:lang_app/pages/templates/highlighted_text.dart';
import 'package:lang_app/pages/templates/input_text_field.dart';
import 'package:lang_app/pages/templates/toast_error_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// TODO TOOTODO: make invalid email/ password input field

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sureNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showLogin = true;

  @override
  void didChangeDependencies() {
    AuthService().logOut();
    super.didChangeDependencies();
  }

  late AppLocalizations local;

  @override
  Widget build(BuildContext context) {
    local = AppLocalizations.of(context)!;
    late List<Widget> show;
    if (_showLogin) {
      show = loginWidget(context);
    } else {
      show = registerWidget(context);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(local.createAccount),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: show,
        ),
      ),
    );
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

  goForwardIfTrue(Future<bool>? argument) async {
    if (argument != null && await argument) {
      DatabaseService().checkProgress(AuthService().uid);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MainScreen(
          index: 0,
        );
      }));
    } else {
      showToastErrorMessage(local.errorLoginData);
    }
  }

  loginButtonAction() {
    var email = _emailController.text;
    var password = _passwordController.text;
    if (email.isEmpty) {
      showToastErrorMessage(local.errorEmptyEmail);
    } else if (password.isEmpty) {
      showToastErrorMessage(local.errorEmptyPassword);
    } else {
      Future<bool>? result =
          AuthService().signInWithEmailAndPassword(email, password);
      goForwardIfTrue(result);
    }
  }

  List<Widget> loginWidget(BuildContext context) {
    return [
      InputTextField(
          icon: Icons.email,
          hint: local.email,
          controller: _emailController,
          obscure: false),
      const SizedBox(height: 20),
      InputTextField(
          icon: Icons.lock,
          hint: local.password,
          controller: _passwordController,
          obscure: true),
      const SizedBox(height: 40),
      formattedButton(local.logIn, () => loginButtonAction()),
      const SizedBox(height: 40),
      highlightedText(
          text: local.registerQuestion,
          onTap: onClickChangeLoginRegister,
          highlightedStyle: Theme.of(context)
              .textTheme
              .subtitle1
              ?.apply(color: Theme.of(context).colorScheme.primary),
          textStyle: Theme.of(context).textTheme.subtitle1),
    ];
  }

  onClickChangeLoginRegister() {
    setState(() {
      _showLogin = !_showLogin;
    });
  }

  registerButtonAction(BuildContext context) {
    var name = _nameController.text;
    var surname = _sureNameController.text;
    var email = _emailController.text;
    var password = _passwordController.text;
    if (name.isEmpty) {
      showToastErrorMessage(local.errorEmptyName);
    } else if (email.isEmpty) {
      showToastErrorMessage(
       local.errorRegisterEmptyEmail 
          );
    } else if (password.isEmpty) {
      showToastErrorMessage(
        local.errorRegisterEmptyPassword
          );
    } else {
      var result = AuthService()
          .registerWithEmailAndPassword(name, surname, email, password);
      showToastErrorMessage(
          local.letterWasSend
          );
      goForwardIfTrue(result);
    }
  }

  List<Widget> registerWidget(BuildContext context) {
    return <Widget>[
      InputTextField(
          icon: Icons.account_circle,
          hint: local.name,
          controller: _nameController,
          obscure: false),
      const SizedBox(height: 20),
      InputTextField(
          icon: Icons.supervised_user_circle,
          hint: local.surnameOptinal,
          controller: _sureNameController,
          obscure: false),
      const SizedBox(height: 20),
      InputTextField(
          icon: Icons.email,
          hint: local.email,
          controller: _emailController,
          obscure: false),
      const SizedBox(height: 20),
      InputTextField(
          icon: Icons.lock,
          hint: local.password,
          controller: _passwordController,
          obscure: true),
      const SizedBox(height: 40),
      formattedButton(local.register, () => registerButtonAction(context)),
      const SizedBox(height: 40),
      highlightedText(
          text: local.loginQuestion,
          onTap: onClickChangeLoginRegister,
          highlightedStyle: Theme.of(context)
              .textTheme
              .subtitle1
              ?.apply(color: Theme.of(context).colorScheme.primary),
          textStyle: Theme.of(context).textTheme.subtitle1),
    ];
  }
}
