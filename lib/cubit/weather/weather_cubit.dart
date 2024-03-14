import 'package:bloc/bloc.dart';
import 'package:tomatopia/api_models/weather_model.dart';
import 'package:tomatopia/api_services/weather_services.dart';
import 'package:tomatopia/cubit/weather/weather_states.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit(this.weatherServices) : super(GetWeatherInitialState());
  WeatherServices weatherServices;

  WeatherModel? weatherModel;

  getWeatherData(String location) {
    weatherServices.getWeather(location).then((value) async {
      weatherModel = WeatherModel.fromJson(value.data);
      emit(GetWeatherSuccessState());
    }).catchError((onError) {
      print('catch error her $onError');
      emit(GetWeatherFailureState());
    });
  }
}
