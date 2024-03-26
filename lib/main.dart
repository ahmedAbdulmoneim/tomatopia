import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/api_services/weather_services.dart';
import 'package:tomatopia/auth/login.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/cubit/profile/profile_cubit.dart';
import 'package:tomatopia/cubit/weather/weather_cubit.dart';
import 'package:tomatopia/shared_preferences/shared_preferences.dart';

import 'cubit/weather/weather_states.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(
        create: (context) => WeatherCubit(WeatherServices(Dio())),
        ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(TomatopiaServices(Dio())),
          ),

        ],
      child: BlocConsumer<WeatherCubit, WeatherStates>(
        builder: (context, state) {
          if (state is GetWeatherInitialState) {
            BlocProvider.of<WeatherCubit>(context).getWeatherData('Beni suef');
          }
          return MaterialApp(
            home: LoginPage(),
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    elevation: .8,
                    shadowColor: Colors.white,
                    color: Colors.white)),
            debugShowCheckedModeBanner: false,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
