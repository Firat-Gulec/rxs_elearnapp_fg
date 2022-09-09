import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/Init/navigation/navigation_service.dart';

NavigationService navigation = NavigationService.instance;

class LoginService {
  Future<void> setLoginUser(String name, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', name);
    prefs.setString('password', password);
  }
  
}
