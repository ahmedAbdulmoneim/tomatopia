import 'package:dio/dio.dart';

import '../api_models/weather_model.dart';

class WeatherServices {
  final Dio dio;

  WeatherServices({required this.dio}) {
    dio.options.baseUrl = 'http://api.weatherapi.com/v1/forecast.json';
    dio.options.receiveDataWhenStatusError = true;
  }

  Future<Response> getWeather(String location) async {
    try {
      final response = await dio.get('', queryParameters: {
        'key': 'aa571eb6f9444cb2b65201614230910',
        'q': location,
      });
      return response;
    } catch (e) {

      print('Error fetching weather data: $e');
      rethrow;
    }
  }
}
