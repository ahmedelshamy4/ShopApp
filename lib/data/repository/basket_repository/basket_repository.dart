import 'dart:developer';

import 'package:flutter_shop_store/data/models/basket_model/update_basket_model.dart';

import '../../models/basket_model/add_basket_model.dart';
import '../../models/basket_model/get_basket_model.dart';
import '../../web_services/local/pref/user_pref.dart';
import '../../web_services/remote/dio_helper.dart';
import '../../web_services/remote/end_points.dart';

class BasketRepository {
  final UserPrefs userPrefs;
  const BasketRepository(this.userPrefs);

  // add To BasketOrderData
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

  // get BasketOrderData
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

  //update BasketOrderData
  Future<UpdateBasketModel> updateBasketOrderData({
    required int productId,
    required int quantity,
  }) async {
    final response = await DioHelper.putData(
      url: '$updateQuantityOrdersUrl$productId',
      data: {
        'quantity': quantity,
      },
      token: UserPrefs().getUserToken(),
    );
    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      log(data.toString());
      return UpdateBasketModel.fromJson(data);
    }
    throw data['message'] as String;
  }

  //delete BasketOrderData
  Future<AddToBasketModel> deleteOrderFromBasketData(
      {required int productId}) async {
    final response = await DioHelper.deleteData(
      url: '$deleteOrdersUrl$productId',
      token: UserPrefs().getUserToken(),
    );
    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return AddToBasketModel.fromJson(data);
    }
    throw data['message'] as String;
  }
}
