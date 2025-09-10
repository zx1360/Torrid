import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}