import 'package:flutter_shop_store/data/web_services/remote/dio_helper.dart';
import 'package:flutter_shop_store/data/web_services/remote/end_points.dart';

import '../../models/address_model/add_new_address_model.dart';
import '../../models/address_model/get_address_model.dart';
import '../../web_services/local/pref/user_pref.dart';

class AddressRepository {
  final UserPrefs userPrefs;
  const AddressRepository(this.userPrefs);
//add address
  Future<AddNewAddressModel> addNewAddressData({
    required String buildingNumber,
    required String city,
    required String region,
    required String details,
    required String notes,
  }) async {
    final response = await DioHelper.postData(
      url: addressesUrl,
      data: {
        'city': city,
        'region': region,
        'details': details,
        'name': buildingNumber,
        'notes': notes,
        'latitude': '0.0',
        'longitude': '0.0',
      },
      token: userPrefs.getUserToken(),
    );
    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return AddNewAddressModel.fromJson(data);
    }

    throw data['message'] as String;
  }

  //get address
  Future<GetAddressModel> getMyAddressData() async {
    final response = await DioHelper.getData(
        url: addressesUrl, token: userPrefs.getUserToken());
    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return GetAddressModel.fromJson(data);
    }
    throw 'server error';
  }

  //update address
  Future<AddNewAddressModel> updateAddressData({
    required int addressId,
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
  }) async {
    final response = await DioHelper.putData(
      url: '$updateAddressesUrl$addressId',
      token: userPrefs.getUserToken(),
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': 0.0,
        'longitude': 0.0,
      },
    );
    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return AddNewAddressModel.fromJson(data);
    }
    throw 'server error';
  }

  //delete address
  Future<AddNewAddressModel> deleteAddressData({required int addressId}) async {
    final response = await DioHelper.deleteData(
      url: '$updateAddressesUrl$addressId',
      token: userPrefs.getUserToken(),
    );
    final data = response.data as Map<String, dynamic>;
    if (data['status'] == true) {
      return AddNewAddressModel.fromJson(data);
    }
    throw 'server error';
  }
}
