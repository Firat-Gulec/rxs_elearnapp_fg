import 'package:flutter/material.dart';

class NormalFormInputField extends TextFormField {
  NormalFormInputField({
    Key? key,
    String? title,
    required ThemeData data,
    required TextEditingController controller,
    Widget? suffixIcon,
    bool isSecure = false,
  }) : super(
          key: key,
          obscureText: isSecure,
          controller: controller,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              fillColor: data.colorScheme.background,
              filled: true,
              suffixIcon: suffixIcon,
              labelText: '$title'),
        );
}
