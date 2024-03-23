class ChangePasswordModel{
  final int statusCode ;
  final String message;

  ChangePasswordModel({required this.statusCode,required this.message});

  factory ChangePasswordModel.fromJson(Map<String,dynamic> json){
    return ChangePasswordModel(
    statusCode: json['stustseCode'],
    message: json['message']);
  }

}