import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tomatopia/constant/variables.dart';

import 'api_services/model_services.dart';
import 'api_services/tomatopia_services.dart';
import 'api_services/weather_services.dart';
import 'auth/login.dart';
import 'constant/constant.dart';
import 'cubit/admin_cubit/admin_cubit.dart';
import 'cubit/ai_cubit/ai_model_cubit.dart';
import 'cubit/auth_cubit/forget_password/forget_password_cubit.dart';
import 'cubit/home_cubit/home_cubit.dart';
import 'cubit/profile/profile_cubit.dart';
import 'cubit/weather/weather_cubit.dart';
import 'cubit/weather/weather_states.dart';

import 'onboarding/splach.dart';
import 'screens/home.dart';
import 'shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyDGS_tQtHp9TP5EJhxufdrwChK96pF4bds',
    appId: '1:951421932351:android:9d12e07e890ddd3bd2f98a',
    messagingSenderId: '951421932351',
    projectId: 'tomatiopianote',
    storageBucket: 'tomatiopianote.appspot.com',
  ));
  await EasyLocalization.ensureInitialized();
  await SharedPreference.init();
  await Hive.initFlutter();


  // Determine the start widget
  Widget widget;
  String onBoardingValue =
      await SharedPreference.getData(key: "onBoarding") ?? "";
  token = await SharedPreference.getData(key: 'token') ?? "";
  userName = await SharedPreference.getData(key: 'userName');
  userEmail = await SharedPreference.getData(key: 'userEmail');
  userId = await SharedPreference.getData(key: 'userId');
  isAdmin = (await SharedPreference.getData(key: 'isAdmin'))
              ?.toString()
              .toLowerCase() ==
          'true' ??
      false;
  userImage = await SharedPreference.getData(key: 'userImage') ?? "";
  if (onBoardingValue.isNotEmpty) {
    widget = token.isNotEmpty ? const Home() : LoginPage();
  } else {
    widget = const SplachScreen();
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: const Locale('en'),
      child: MyApp(startWidget: widget),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget}) : super(key: key);

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
          create: (context) =>
              AiCubit(AIModelServices(Dio()), TomatopiaServices(Dio())),
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
          return GetMaterialApp(
            home: startWidget,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                elevation: .8,
                shadowColor: Colors.white,
                color: Colors.white,
              ),
            ),
            debugShowCheckedModeBanner: false,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
