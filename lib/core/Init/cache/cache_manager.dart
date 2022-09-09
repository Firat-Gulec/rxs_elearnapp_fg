import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  /* Future<bool> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }*/

  Future<void> setNavigation(String navigate) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("navigate", navigate);
  }

  Future<String?> setQuestionnaire(String name, String loadstring) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("surveyname", name);
    prefs.setString('loadstring', loadstring);
    return null;
    //setQuestionnaire('name', 'assets/questionnaires/login_survey.json');
    //navigation.navigateToPage(path: NavigationConstants.QUESTIONNAIRE);
  }

  Future<void> setLogin(String name, String pass) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
    prefs.setString("password", pass);
  }
/*
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(CacheManagerKey.TOKEN.toString());
  }*/

  Future<String?> getQuestionnaire() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('loadstring');
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<String?> getUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }
}

//enum CacheManagerKey { TOKEN }
