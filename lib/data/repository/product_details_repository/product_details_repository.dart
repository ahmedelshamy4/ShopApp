import 'package:flutter_shop_store/data/models/product_details_model/product_details.dart';
import 'package:flutter_shop_store/data/web_services/remote/end_points.dart';

import '../../../shared/constants/constant.dart';
import '../../web_services/remote/dio_helper.dart';

class ProductDetailsRepository {
  Future<ProductDetailsModel> getProductDetailsData(
      {required int productId}) async {
    final response = await DioHelper.getData(
        url: productsDetailsUrl + productId.toString(), token: userToken);
    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return ProductDetailsModel.fromJson(data);
    }
    throw 'server error';
  }
}
