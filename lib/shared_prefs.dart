import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  static Future<SharedPreferences> pref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}