import 'package:flutter/material.dart';

import 'onboarding/splach.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplachScreen(),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              elevation: .8, shadowColor: Colors.white, color: Colors.white)),
      debugShowCheckedModeBanner: false,
    );
  }
}
