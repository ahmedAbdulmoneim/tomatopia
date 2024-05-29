class LoginModel {
  final String name;
  final String email;
  final String token;
  final String? image;
  final String? userId;

  LoginModel({this.userId,required this.name, required this.email, required this.token,required this.image});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      name: json['fullName'],
      email: json['email'],
      token: json['token'],
      image: json['image'],
      userId: json['userId'],
    );
  }
}
