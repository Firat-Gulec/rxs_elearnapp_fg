import 'package:flutter/material.dart';

class SecureIcon extends Icon {
  // ignore: use_key_in_widget_constructors
  const SecureIcon({required bool isSecure})
      : super(isSecure ? Icons.visibility : Icons.visibility_off);
}
