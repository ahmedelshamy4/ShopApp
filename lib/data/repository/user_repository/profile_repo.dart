import 'dart:developer';

import 'package:flutter_shop_store/data/web_services/local/pref/user_pref.dart';
import 'package:flutter_shop_store/data/web_services/remote/dio_helper.dart';
import 'package:flutter_shop_store/data/web_services/remote/end_points.dart';

import '../../models/login_model/profile.dart';

class ProfileRepository {
  final UserPrefs userPrefs;
  ProfileRepository(this.userPrefs);
  //get user data
  Future<ProfileModel> getUserData() async {
    final response = await DioHelper.getData(
        url: profileUrl, token: userPrefs.getUserToken());

    final data = response.data as Map<String, dynamic>;
    log(data.toString());
    if (data['status'] == true) {
      return ProfileModel.fromJson(data);
    }
    throw 'server error';
  }
}
