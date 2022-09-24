import 'package:flutter/material.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/core/database.dart';
import 'package:lang_app/pages/main_screen.dart';
import 'package:lang_app/pages/templates/highlighted_text.dart';
import 'package:lang_app/pages/templates/input_text_field.dart';
import 'package:lang_app/pages/templates/toast_error_message.dart';

/**
 * TOTOTOOTODO: make invalid email/ password input field
 */

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
        title: const Text('Створіть свій акаунт!'),
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
        return const MainScreen();
      }));
    } else {
      //TODO think about if false
    }
  }

  loginButtonAction(BuildContext context) {
    var email = _emailController.text;
    var password = _passwordController.text;
    if (email.isEmpty) {
      showToastErrorMessage("Без імейлу не пройдете!");
    }
    else if (password.isEmpty) {
      showToastErrorMessage("Ми впевнені, що ви створювали пароль. Тож введіть його, не соромтесь☺");
    }
    else {
      Future<bool>? result =
      AuthService()
          .signInWithEmailAndPassword(email, password);
      goForwardIfTrue(result);
    }
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
          hint: 'Пароль',
          controller: _passwordController,
          obscure: true),
      const SizedBox(height: 40),
      formattedButton('ВВІЙТИ', () => loginButtonAction(context)),
      const SizedBox(height: 40),
      highlightedText(
          text: 'Не маєте акаунта? |Реєстрація|',
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
      showToastErrorMessage("Секретні ви наші, ім'я не може бути пустим!☺");
    }
    else if (email.isEmpty){
      showToastErrorMessage("Без імейлу - то прикол, але все ж краще введіть його!☺");
    }
    else if (password.isEmpty){
      showToastErrorMessage("Без паролю??? Ви що, хочете щоб вас взламали легше, ніж то і так є?");
    }
    else {
      var result = AuthService()
          .registerWithEmailAndPassword(name, surname, email, password);
      showToastErrorMessage("Надіслали Вам листа з підтвердженянм імейлу (Перевірте спам, наш розробник, себто я, півроку не міг зрозуміти куди скидується цей лист, поки не перевірив спам...)");
      goForwardIfTrue(result);
    }
  }

  List<Widget> registerWidget(BuildContext context) {
    return <Widget>[
      InputTextField(
          icon: Icons.account_circle,
          hint: 'Ім`я',
          controller: _nameController,
          obscure: false),
      const SizedBox(height: 20),
      InputTextField(
          icon: Icons.supervised_user_circle,
          hint: 'Прізвище(за бажанням)',
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
          hint: 'Пароль',
          controller: _passwordController,
          obscure: true),
      const SizedBox(height: 40),
      formattedButton('ЗАРЕЄСТРУВАТИСЬ', () => registerButtonAction(context)),
      const SizedBox(height: 40),
      highlightedText(
          text: 'Вже зареєстровані? |Увійти|',
          onTap: onClickChangeLoginRegister,
          highlightedStyle: Theme.of(context)
              .textTheme
              .subtitle1
              ?.apply(color: Theme.of(context).colorScheme.primary),
          textStyle: Theme.of(context).textTheme.subtitle1),
    ];
  }

}

