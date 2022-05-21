import '../../models/search_model.dart/search_model.dart';
import '../../web_services/local/pref/user_pref.dart';
import '../../web_services/remote/dio_helper.dart';
import '../../web_services/remote/end_points.dart';

class SearchRepository {
  Future<SearchModel> getSearchData({required String text}) async {
    final response = await DioHelper.postData(
      url: searchUrl,
      data: {"text": text},
      token: UserPrefs().getUserToken(),
    );
    final data = response.data as Map<String, dynamic>;

    if (data['status'] == true) {
      return SearchModel.fromJson(data);
    }
    throw 'server error';
  }
}
