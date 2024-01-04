import 'package:shared_preferences/shared_preferences.dart';

class MyShared {
  static SharedPreferences? preferences;

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void putBoolean({
    required String key,
    required bool value,
  }) async {
    await preferences!.setBool(key, value);
  }

  static bool? getBoolean({required String key}) {
    return preferences!.getBool(key);
  }

  static void putString({
    required String key,
    required String value,
  }) async {
    await preferences!.setString(key, value);
  }

  static String? getString({required String key}) {
    return preferences!.getString(key);
  }
}
