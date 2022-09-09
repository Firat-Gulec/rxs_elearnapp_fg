import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../cache/cache_manager.dart';






class AuthenticationManager extends CacheManager {
  BuildContext context;
  AuthenticationManager({
    required this.context,
  }) {
    fetchUserLogin();
  }
  bool isLogin = false;
    UserModel? model;

  Future<void> fetchUserLogin() async {
    final token = await getUserLogin();
    if (token != null) {
      isLogin = true;
    }
  }
}
