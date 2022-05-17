import 'dart:developer';

import 'package:flutter_shop_store/data/web_services/local/pref/pref_setup.dart';
import 'package:flutter_shop_store/shared/constants/constant.dart';

class UserPrefs {
  final perfs = SharedPrefs.preferences;

  Future<void> setUserToken(String token) => perfs.setString(userToken, token);
  String getUserToken() => perfs.getString(userToken) ?? 'error token';
  Future<void> deleteUserToken() => perfs.remove(userToken);

  bool isUserLoggedIn() {
    final token = perfs.getString('token');
    log(token.toString());
    return token != null;
  }
}
