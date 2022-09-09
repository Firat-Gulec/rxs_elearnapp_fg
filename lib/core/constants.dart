import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppConstant {
  // ignore: constant_identifier_names
  static const EN_LOCALE = Locale("en", "US");
  // ignore: constant_identifier_names
  static const TR_LOCALE = Locale("tr", "TR");
  // ignore: constant_identifier_names
  static const DE_LOCALE = Locale("de", "DE");
  // ignore: constant_identifier_names
  static const RU_LOCALE = Locale("ru", "RU");
  // ignore: constant_identifier_names
  static const LANG_PATH = "assets/lang";
}




final supabase = Supabase.instance.client;

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}