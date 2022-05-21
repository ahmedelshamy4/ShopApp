import '../../models/login_model/login_model.dart';
import '../../web_services/remote/dio_helper.dart';
import '../../web_services/remote/end_points.dart';

class RegisterRepository {
  Future<LoginModel> userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    final response = await DioHelper.postData(
      url: registerUrl,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    );
    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return LoginModel.fromJson(data);
    }
    throw data['message'] as String;
  }
}
