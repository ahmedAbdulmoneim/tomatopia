class RegisterModel {
  String? fullName;
  String? userId;
  String? email;

  String? token;

  RegisterModel({this.fullName, this.userId, this.email, this.token});

  // Create a RegisterModel from JSON
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      fullName: json['fullName'],
      userId: json['userId'],
      email: json['email'],
      token: json['token'],
    );
  }


}


