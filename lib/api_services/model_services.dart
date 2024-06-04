import 'package:dio/dio.dart';

class AIModelServices {
  Dio dio;

  AIModelServices(this.dio);

  Future<Response> postDisease({required dynamic data}) async {
    Response response = await dio.post('http://3.218.84.44:8000/predict', data: data);
    return response;
  }
}
