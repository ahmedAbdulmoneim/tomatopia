import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tomatopia/cubit/home_cubit/home_cubit.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import '../cubit/home_cubit/home_states.dart';
import '../screens/search_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _initFirebaseMessaging();
  }

  void _initFirebaseMessaging() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings;

    if (notificationsEnabled) {
      settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    } else {
      settings = await messaging.requestPermission(
        alert: false,
        badge: false,
        sound: false,
      );
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        return Scaffold(
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: cubit.currentIndex,
            itemCornerRadius: 15,
            curve: Curves.easeInBack,
            items: [
              BottomNavyBarItem(
                icon: const Icon(Icons.home),
                title: Text(context.home),
                activeColor: Colors.green,
                inactiveColor: Colors.black,
              ),
              BottomNavyBarItem(
                activeColor: Colors.deepOrange,
                inactiveColor: Colors.black,
                icon: const Icon(Icons.chat_outlined),
                title: Text(context.community),
              ),
              BottomNavyBarItem(
                activeColor: Colors.red,
                inactiveColor: Colors.black,
                icon: const Icon(Icons.crisis_alert),
                title: Text(context.reminder),
              ),
            ],
            onItemSelected: (value) {
              cubit.onSelectedItem(value: value);
              if (value == 1) {
                cubit.getAllPost();
              }
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
