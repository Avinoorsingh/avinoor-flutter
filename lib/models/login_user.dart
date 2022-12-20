class LoginUserModel {
  String? userId;
  String? password;

  LoginUserModel({required this.userId, required this.password});

  LoginUserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['password'] = password;
    return data;
  }
}