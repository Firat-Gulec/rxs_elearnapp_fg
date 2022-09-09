// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:casbin/casbin.dart';

import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import 'package:provider/src/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/Init/auth/auth_manager.dart';
import '../../core/Init/cache/cache_manager.dart';
import '../../core/Init/navigation/navigation_constants.dart';
import '../../core/Init/navigation/navigation_service.dart';
import '../../core/utilities/supabase_helper.dart';
import '../../core/Init/auth/auth_state.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends AuthState<SplashScreen> with CacheManager {
  bool _isVisible = true;
  NavigationService navigation = NavigationService.instance;
  late final String userName;
  late final String userPass;
  late final String navigateString;
  late final model;
  late final enforcer;
  AuthenticationManager readAuthManager() =>
      context.read<AuthenticationManager>();

  loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recoverSupabaseSession();
      userName = prefs.getString("name") ?? "null";
      userPass = prefs.getString("password") ?? "null";
    });
    if (userName != "null") {
      final res = await SupabaseHelper().signinExitingUser(userName, userPass);
      navigation.navigateToPage(path: NavigationConstants.PROFILE_VIEW);
    }
  }

  _SplashScreenState() {
    Timer(const Duration(milliseconds: 2000), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        loadUserId();
        navigateString = prefs.getString("navigate") ?? "/login";
        readAuthManager().fetchUserLogin();
        // ignore: avoid_print
        print(navigateString);
        navigation.navigateToPage(path: navigateString);
      });
    });
    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        
        _isVisible =
            true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).backgroundColor,
            Theme.of(context).primaryColor
          ],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 300.0,
            width: 300.0,
            child: Center(
              child: Image.asset(
                'assets/images/rixos_logo.png',
                width: size.width * 0.50,
              ), //put your logo here
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 2.0,
                    offset: const Offset(5.0, 3.0),
                    spreadRadius: 2.0,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
