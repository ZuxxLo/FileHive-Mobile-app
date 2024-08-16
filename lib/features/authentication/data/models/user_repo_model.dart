// ignore_for_file: unnecessary_this

import 'package:filehive/core/utils/shared_preferences/pref_utils.dart';
import 'package:filehive/features/authentication/data/models/login_response.dart';

class UserRepository {
  User? _user;
  String? _accessToken;

  User? get user => _user;
  String? get accessToken => _accessToken;

  setUser(User user, String accessToken) async {
    _user = user;
    _accessToken = accessToken;
    await PrefUtils.storeUserToken(accessToken);
  }

  Future<void> clearUser() async {
    _user = null;
    _accessToken = null;
    await PrefUtils.clearUserAndToken();
  }

  Future<void> loadUserToken() async {
    print(
        "loadUserTokenloadUserTokenloadUserTokenloadUserTokenloadUserTokenloadUserToken");
    _accessToken = await PrefUtils.getUserToken();
  }
}
