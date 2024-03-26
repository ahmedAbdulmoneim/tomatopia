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
      dio.options.headers = { 'Authorization': 'Bearer $token',
      };
    Response response = await dio.post('$baseUrl$endPoint', data: data);
      print(response.data);
      return response;

  }

  Future<Response>getData({
    required String endPoint,
    String? token,
})async{
    dio.options.headers = {'Authorization': 'Bearer $token'};
    Response response = await dio.get('$baseUrl$endPoint');
    print(response.data);
    return response;
  }

  Future<Response> update({
    required String endPoint,
    required Map<String,dynamic> query,
    String? token,
  }) async {
    dio.options.headers = { 'Authorization': 'Bearer $token',
    };
    Response response = await dio.put('$baseUrl$endPoint', queryParameters: query);
    print(response.data);
    return response;

  }
}
