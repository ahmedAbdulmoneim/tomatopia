import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:tomatopia/screens/alerts_screen.dart';
import 'package:tomatopia/screens/community.dart';
import 'package:tomatopia/screens/home_screen.dart';
import 'package:tomatopia/screens/search_screen.dart';
import 'package:tomatopia/screens/settings_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    Search(),
    Community(),
    Alerts(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        itemCornerRadius: 15,
        curve: Curves.easeInBack,
        items: [
          BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text(
                'Home',
              ),
              activeColor: Colors.green,
          inactiveColor: Colors.black,),
          BottomNavyBarItem(
              activeColor: Colors.lightBlueAccent,
              inactiveColor: Colors.black,
              icon: const Icon(Icons.search), title: const Text('Search')),
          BottomNavyBarItem(
              activeColor: Colors.deepOrange,
              inactiveColor: Colors.black,
              icon: const Icon(Icons.chat_outlined),
              title: const Text('Community')),
          BottomNavyBarItem(
              activeColor: Colors.red,
              inactiveColor: Colors.black,
              icon: const Icon(Icons.crisis_alert), title: const Text('Alert')),
          BottomNavyBarItem(
              activeColor: Colors.blue,
              inactiveColor: Colors.black,
              icon: const Icon(Icons.settings), title: const Text('Settings')),
        ],
        onItemSelected: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      body: screens[currentIndex],
    );
  }
}
