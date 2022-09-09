import 'package:flutter/material.dart';

class PasswordInputField extends TextField {
  PasswordInputField({
    Key? key,
    String? title,
    required ThemeData data,
    required TextEditingController controller,
    Widget? suffixIcon,
    bool isSecure = false,
    required bool obscureText,
  }) : super(
          key: key,
          controller: controller,
          decoration: InputDecoration(
              hoverColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
              suffixIcon: suffixIcon,
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.brown),
              filled: true,
              labelText: '$title'),
          obscureText: obscureText,
        );
}
