import 'package:flutter/material.dart';

class NormalInputField extends TextFormField {
  NormalInputField(
      {Key? key,
      String? title,
      required ThemeData data,
      required TextEditingController controller,
      required onChanged})
      : super(
          key: key,
          cursorColor: Colors.white,
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
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.brown),
              filled: true,
              labelText: '$title'),
          controller: controller,
        );
}
