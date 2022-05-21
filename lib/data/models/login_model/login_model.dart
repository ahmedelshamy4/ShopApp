class LoginModel {
  final String message;
  final UserData data;
  final bool status;

  LoginModel({
    required this.message,
    required this.data,
    required this.status,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: UserData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class UserData {
  final int id;
  final dynamic points;
  final dynamic credit;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String token;

  UserData({
    required this.id,
    required this.points,
    required this.credit,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.token,
  });
  factory UserData.fromJson(Map<String, dynamic> json) {
    //داتا االلي بتيجي
    return UserData(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String,
      points: json['points'],
      credit: json['credit'],
      token: json['token'] as String,
    );
  }
}
