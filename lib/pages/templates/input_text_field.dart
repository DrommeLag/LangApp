import 'package:flutter/material.dart';

class InputTextField extends Container {
  InputTextField({Key? key, required TextEditingController controller, bool obscure = false, String? hint,IconData? icon, double fontSize = 20})
      : super(
          key: key,
          child: TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
              hintText: hint,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                ),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Icon(icon),
              ),
            ),
          ),
        );
}
