import 'package:flutter/material.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Змінити пароль")),
        body: SafeArea(
            child: ListView(children: [TextFormField(
            keyboardType: TextInputType.text,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              labelText: 'Пароль',
              hintText: 'Введіть новий пароль',
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
            ),
            validator: (String? value) {
              return (value != null) ? 'Поле не може бути пустим' : null;
            },
          ),
          //TODO: Implement password update
        ])));
  }
}
