import '../../models/orders_model/orders_model.dart';
import '../../web_services/local/pref/user_pref.dart';
import '../../web_services/remote/dio_helper.dart';
import '../../web_services/remote/end_points.dart';

class OrdersRepository {
  final UserPrefs userPrefs;
  OrdersRepository(this.userPrefs);

  Future<OrdersModel> getOrder() async {
    final response = await DioHelper.getData(
        url: myOrdersUrl, token: userPrefs.getUserToken());

    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return OrdersModel.fromJson(data);
    }
    throw 'server error';
  }
}
