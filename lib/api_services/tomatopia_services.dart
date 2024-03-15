import 'package:dio/dio.dart';

class TomatopiaServices {
  Dio dio;

  TomatopiaServices(this.dio);

  String baseUrl = 'http://graduationproject.somee.com/api/';

  Future<Response> postData({
    required String endPoint,
    required Map<String,dynamic> data,
    String? token,
  }) async {

      Response response = await dio.post('$baseUrl$endPoint', data: data);
      print(response.data);
      return response;

  }
}
