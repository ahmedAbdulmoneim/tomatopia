
class DeleteModel{
  int statusCode ;
  String message ;

  DeleteModel({required this.message,required this.statusCode});
  factory DeleteModel.fromJson(Map<String,dynamic> json){
    return DeleteModel(
        statusCode: json['stustseCode'],
        message: json['message']
    );
  }
}