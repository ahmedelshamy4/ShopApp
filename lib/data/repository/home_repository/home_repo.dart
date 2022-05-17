import 'package:flutter_shop_store/data/models/home_model/banner_model.dart';
import 'package:flutter_shop_store/data/models/home_model/product_model.dart';
import 'package:flutter_shop_store/data/web_services/remote/dio_helper.dart';
import 'package:flutter_shop_store/shared/constants/constant.dart';

import '../../web_services/remote/end_points.dart';

class HomeRepository {
  // get HomeData
  Future<HomeModel> getHomeData() async {
    final response =
        await DioHelper.getData(url: productsUrl, token: userToken);

    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return HomeModel.fromJson(data);
    }
    throw 'server error';
  }

  // get BannerData
  Future<BannerModel> getBannerData() async {
    final response = await DioHelper.getData(url: bannerUrl, token: userToken);

    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return BannerModel.fromJson(data);
    }
    throw 'server error';
  }
}
