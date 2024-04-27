class ForgetPasswordModel {
  String? email;
  String? token;
  String? confirmCode;

  ForgetPasswordModel({this.email, this.token, this.confirmCode});

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    token = json['token'];
    confirmCode = json['confirmCode'];
  }


}
