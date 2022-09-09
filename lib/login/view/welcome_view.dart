import 'package:flutter/material.dart';



import 'package:shared_preferences/shared_preferences.dart';

import '../../core/Init/cache/cache_manager.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> with CacheManager {
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setNavigation("/welcome");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          clearCache();
        },
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(20)),
              Image.asset(
                'assets/images/rixos_logo.png',
                width: size.width * 0.50,
              ),
              Padding(padding: EdgeInsets.all(20)),
            ]),
      ),
    );
  }
}
