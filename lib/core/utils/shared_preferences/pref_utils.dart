import 'package:shared_preferences/shared_preferences.dart';

import 'pref_utils_keys.dart';

abstract class PrefUtils {
  static SharedPreferences? prefs;

  static Future<void> initSharredPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> storeUserToken(String accessToken) async {
    prefs!.setString(PrefUtilsKeys.accessTokenKey, accessToken);
  }

  static Future<String?> getUserToken() async {
    return prefs!.getString(PrefUtilsKeys.accessTokenKey);
  }

  static Future<void> clearUserAndToken() async {
    prefs!.remove(PrefUtilsKeys.accessTokenKey);
  }
}
