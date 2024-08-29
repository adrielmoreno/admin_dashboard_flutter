import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}
