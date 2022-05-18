import '../../../shared/constants/constant.dart';
import '../../models/notifications_model/notifications_model.dart';
import '../../web_services/remote/dio_helper.dart';
import '../../web_services/remote/end_points.dart';

class NotificationsRepository {
  Future<NotificationsModel> getNotificationsData() async {
    final response =
        await DioHelper.getData(url: notificationsUrl, token: userToken);
    final data = response.data as Map<String, dynamic>;

    if (data['status'] == true) {
      return NotificationsModel.fromJson(data);
    }
    throw 'server error';
  }
}
