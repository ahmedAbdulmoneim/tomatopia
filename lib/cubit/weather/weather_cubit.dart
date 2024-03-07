import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:tomatopia/api_models/weather_model.dart';
import 'package:tomatopia/api_services/weather_services.dart';
import 'package:tomatopia/cubit/weather/weather_states.dart';

class WeatherCubit extends Cubit<WeatherStates>{
  WeatherCubit(this.weatherServices) : super(GetWeatherInitialState());
  WeatherServices weatherServices ;
  WeatherModel? weatherModel;
  getWeatherData(String location){
    emit(GetWeatherLoadingState());
    weatherServices.getWeather(location).then((value) {
      // WeatherModel.fromJson(value.data);
      weatherModel = WeatherModel.fromJson(value.data);
      print(weatherModel!.location!.region);
      emit(GetWeatherSuccessState());
    }).catchError((onError){
      print('catch error her $onError');
      emit(GetWeatherFailureState());
    });
  }
}