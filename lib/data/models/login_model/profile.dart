class ProfileModel {
  final bool status;
  final ProfileData data;

  ProfileModel({
    required this.status,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'] as bool,
      data: ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class ProfileData {
  final int id;
  late final String name;
  late final String email;
  late final String phone;
  late final String image;
  final int points;
  final dynamic credit;
  final String token;

  ProfileData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String,
      points: json['points'] as int,
      credit: json['credit'],
      token: json['token'] as String,
    );
  }
}
