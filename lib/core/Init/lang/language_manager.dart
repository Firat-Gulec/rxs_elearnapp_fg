// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final EN_LOCALE = const Locale("en", "US");
  final TR_LOCALE = const Locale("tr", "TR");
  final DE_LOCALE = const Locale("de", "DE");
  final RU_LOCALE = const Locale("ru", "RU");

  List<Locale> get supportedLocales =>
      [EN_LOCALE, TR_LOCALE, DE_LOCALE, RU_LOCALE];
}
