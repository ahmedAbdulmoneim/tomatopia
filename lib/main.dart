import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/api_services/model_services.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/api_services/weather_services.dart';
import 'package:tomatopia/auth/login.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/cubit/ai_cubit/ai_model_cubit.dart';
import 'package:tomatopia/cubit/auth_cubit/forget_password/forget_password_cubit.dart';
import 'package:tomatopia/cubit/profile/profile_cubit.dart';
import 'package:tomatopia/cubit/weather/weather_cubit.dart';
import 'package:tomatopia/onboarding/onboarding.dart';
import 'package:tomatopia/screens/home.dart';
import 'package:tomatopia/shared_preferences/shared_preferences.dart';

import 'cubit/home_cubit/home_cubit.dart';
import 'cubit/weather/weather_states.dart';
import 'onboarding/splach.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreference.init();
  Widget widget ;
  String onBoardingValue = await SharedPreference.getData(key: "onBoarding") ?? "" ;
  token = await SharedPreference.getData(key: 'token') ?? "";

  if(onBoardingValue != ""){
    if(token != ""){
      widget = Home();
    }else{
      widget = LoginPage();
    }
  }else{
    widget = SplachScreen();
  }

  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key,required this.startWidget}) : super(key: key);
  Widget startWidget;

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
          BlocProvider<AdminCubit>(
            create: (context) => AdminCubit(TomatopiaServices(Dio())),
          ),
          BlocProvider<ForgetPasswordCubit>(
            create: (context) => ForgetPasswordCubit(TomatopiaServices(Dio())),
          ),
          BlocProvider<AiCubit>(
            create: (context) => AiCubit(AIModelServices(Dio())),
          ),
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(TomatopiaServices(Dio())),
          ),
        ],
      child: BlocConsumer<WeatherCubit, WeatherStates>(
        builder: (context, state) {
          if (state is GetWeatherInitialState) {
            BlocProvider.of<WeatherCubit>(context).getWeatherData('Beni suef');
          }
          return MaterialApp(
            home: startWidget,
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
