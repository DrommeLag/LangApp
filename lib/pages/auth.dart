import 'package:flutter/material.dart';
import '../domain/user.dart';
import 'package:lang_app/login/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surenameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _name ='';
  String _surename = '';
  // String _phoneNumber = '';
  String _email = '';
  String _password = '';
  bool _showLogin = true;

  AuthService _authService = AuthService();

  Widget input(Icon icon, String hint, TextEditingController controller, bool obscure) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black38,
          ),
          hintText: hint,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 3,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black54,
              width: 1,
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: IconTheme(
              data: const  IconThemeData(
                color: Colors.black,
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }

  void loginButtonAction() async{
    _email = _emailController.text;
    _password = _passwordController.text;
    if(_email.isEmpty || _password.isEmpty) return;
    MyUser? user = await _authService.signInWithEmailAndPassword(_email.trim(), _password.trim());
    if(user == null){
      Fluttertoast.showToast(
          msg: "Can`t sign you in. Please check your email/password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  void registerButtonAction() async{
    _name = _nameController.text;
    _surename = _surenameController.text;
    _email = _emailController.text;
    _password = _passwordController.text;
    if(_name.isEmpty || _email.isEmpty || _password.isEmpty) return;
    MyUser? user = await _authService.registerWithEmailAndPassword(_name, _surename, _email.trim(), _password.trim());
    if(user == null){
      Fluttertoast.showToast(
          msg: "Can`t register you. Please check your name/email/password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      _nameController.clear();
      _surenameController.clear();
      _emailController.clear();
      _passwordController.clear();
    }
  }

  Widget button(String text, void func()) {
    return ElevatedButton(
      onPressed: () {
        func();
      },
      child: Text(text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Create your account!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
      ),
      body: (
          _showLogin
              ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 140),
                child: input(const Icon(Icons.email), 'Email', _emailController, false),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: input(const Icon(Icons.lock), 'Password', _passwordController, true),
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: button('LOGIN', loginButtonAction),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not registered?',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      child: const Text('   Register',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepOrange,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _showLogin = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
              : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 30),
                child: input(const Icon(Icons.account_circle), 'Name', _nameController, false),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: input(const Icon(Icons.supervised_user_circle), 'Surename(optional)', _surenameController, false),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: input(const Icon(Icons.email), 'Email', _emailController, false),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: input(const Icon(Icons.lock), 'Password', _passwordController, true),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: button('REGISTER', registerButtonAction),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already registered?',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      child: const Text('   Login',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepOrange,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _showLogin = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
