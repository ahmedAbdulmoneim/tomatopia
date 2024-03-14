import 'package:dio/dio.dart';

class WeatherServices {
  final Dio dio;

  WeatherServices(this.dio);

  final String baseUrl = 'http://api.weatherapi.com/v1';

  Future<Response> getWeather(cityName) async {
    dio.options.queryParameters = {
      'key': 'aa571eb6f9444cb2b65201614230910',
      'q': '$cityName',
      'days': '3'
    };
    try {
      Response response = await dio.get(
        '$baseUrl/forecast.json',
      );

      return response;
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['error']['message'] ??
          'oops there was an error ,try later';
      throw (errorMessage);
    }
  }
}
