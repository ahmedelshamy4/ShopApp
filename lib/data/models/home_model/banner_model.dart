class BannerModel {
  final bool status;
  final String message;
  final List<BannerData> data;

  BannerModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      status: json['status'] as bool,
      message: json['message'] as String? ?? '',
      data: (json['data'] as List<dynamic>)
          .map(
              (element) => BannerData.formJson(element as Map<String, dynamic>))
          .toList(),
    );
  }
}

class BannerData {
  final int id;
  final String image;

  BannerData({required this.id, required this.image});
  factory BannerData.formJson(Map<String, dynamic> json) {
    return BannerData(
      id: json['id'] as int,
      image: json['image'] as String,
    );
  }
}
