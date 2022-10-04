import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import 'core/Init/auth/auth_manager.dart';
import 'core/Init/lang/language_manager.dart';
import 'core/Init/navigation/navigation_route.dart';
import 'core/Init/navigation/navigation_service.dart';
import 'core/Init/provider/theme_provider.dart';
import 'core/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Supabase.initialize(
    url: 'https://sgulfrkzsmagewgaqqhe.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNndWxmcmt6c21hZ2V3Z2FxcWhlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjExNzAwNDcsImV4cCI6MTk3Njc0NjA0N30.HkbBzlqSQyuPIQI4o47uW5blE8ojmBQGLLIzxoVheSg',
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthenticationManager>(
          create: (context) => AuthenticationManager(context: context),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: ((context) => ThemeProvider()),
        ),
      ],
      child: EasyLocalization(
        child: MyApp(),
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: AppConstant.LANG_PATH,
        //  startLocale: LanguageManager.instance.EN_LOCALE,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'RXS',
      themeMode: themeProvider.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
