import '../../models/login_model/login_model.dart';
import '../../web_services/remote/dio_helper.dart';
import '../../web_services/remote/end_points.dart';

class LoginRepository {
  Future<LoginModel> userLogin({
    required String email,
    required String password,
  }) async {
    final response = await DioHelper.postData(
      url: loginUrl,
      data: {
        'email': email,
        'password': password,
      },
    );
    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return LoginModel.fromJson(data);
    }
    throw 'Email or password invalid';
  }
}
