class LoginModel {
  final String name;
  final String email;
  final String token;

  LoginModel({required this.name, required this.email, required this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      name: json['fullName'],
      email: json['email'],
      token: json['token'],
    );
  }
}
