import 'dart:developer';

import '../../web_services/local/pref/user_pref.dart';
import '../../web_services/remote/dio_helper.dart';
import '../../web_services/remote/end_points.dart';

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

  // update user data
  Future<ProfileModel> updateUserData({
    String? name,
    String? email,
    String? phone,
    String? image,
    String? password,
  }) async {
    final response = await DioHelper.putData(
      url: updateProfileUrl,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
        'password': password,
      },
      token: userPrefs.getUserToken(),
    );

    final data = response.data as Map<String, dynamic>;
    log(data.toString());
    if (data['status'] == true) {
      return ProfileModel.fromJson(data);
    }
    throw data['message'] as String;
  }
}
