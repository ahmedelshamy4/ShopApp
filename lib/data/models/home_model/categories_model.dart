class CategoriesModel {
  final bool status;
  final String message;
  final Data data;

  CategoriesModel(
      {required this.status, required this.message, required this.data});
  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      status: json['status'] as bool,
      message: json['message'] as String? ?? '',
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class Data {
  final int currentPage;
  final List<CategoriesData> productData;
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      currentPage: json['current_page'] as int,
      productData: (json['data'] as List<dynamic>)
          .map((element) =>
              CategoriesData.fromJson(element as Map<String, dynamic>))
          .toList(),
    );
  }

  Data({required this.currentPage, required this.productData});
}

class CategoriesData {
  final int id;
  final String image;
  final String name;

  const CategoriesData({
    required this.id,
    required this.image,
    required this.name,
  });

  factory CategoriesData.fromJson(Map<String, dynamic> json) {
    return CategoriesData(
      id: json['id'] as int,
      image: json['image'] as String,
      name: json['name'] as String,
    );
  }
}
