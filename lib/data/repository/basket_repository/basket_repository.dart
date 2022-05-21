import '../../models/basket_model/add_basket_model.dart';
import '../../models/basket_model/get_basket_model.dart';
import '../../web_services/remote/dio_helper.dart';
import '../../web_services/remote/end_points.dart';

import '../../web_services/local/pref/user_pref.dart';

class BasketRepository {
  final UserPrefs userPrefs;
  const BasketRepository(this.userPrefs);

  // add To Basket Orders
  Future<AddToBasketModel> addToBasketOrders(int productId) async {
    final response = await DioHelper.postData(
      url: basketUrl,
      data: {'product_id': productId},
      token: userPrefs.getUserToken(),
    );

    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return AddToBasketModel.fromJson(data);
    }
    throw data['message'] as String;
  }

  // get My Basket Orders Data
  Future<BasketGetOrdersModel> getBasketOrders() async {
    final response = await DioHelper.getData(
      url: basketUrl,
      token: userPrefs.getUserToken(),
    );

    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return BasketGetOrdersModel.fromJson(data);
    }
    throw data['message'] as String;
  }
}
