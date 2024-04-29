import 'package:dio/dio.dart';

class TomatopiaServices {
  Dio dio;

  TomatopiaServices(this.dio);

  String baseUrl = 'http://graduationprojec.runasp.net/api/';

  Future<Response> postData({
    required String endPoint,
    required dynamic data,
    String? token,
    Map<String,dynamic>? parameters ,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    Response response = await dio.post('$baseUrl$endPoint', data: data,queryParameters: parameters);
    return response;
  }

  Future<Response> getData({
    required String endPoint,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {'Authorization': 'Bearer $token'};
    Response response =
        await dio.get('$baseUrl$endPoint', queryParameters: query);
    return response;
  }

  Future<Response> update({
    required String endPoint,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    Response response =
        await dio.put('$baseUrl$endPoint', queryParameters: query, data: data);
    return response;
  }

  Future<Response> deleteRequest({
    required String token,
    required String endpoint,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    Response response = await dio.delete(
      "$baseUrl$endpoint",
      queryParameters: query,
    );
    return response;
  }
}
