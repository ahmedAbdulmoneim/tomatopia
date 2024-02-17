import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import '../auth/login.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);
  final pages = [
    PageViewModel(
      pageColor: Colors.green,
      mainImage: Image.asset('assets/img_1.png'),
      bubble: Image.asset('assets/tm.png'),
      title: const Text('Take a photo'),
      body: const Text(
          'Receive instant identification and treatment suggestions'),
      bodyTextStyle: const TextStyle(color: Colors.black),
      titleTextStyle: const TextStyle(color: Colors.black),
    ),
    PageViewModel(
      mainImage: Image.asset('assets/intro3.png'),
      bubble: Image.asset('assets/tm.png'),
      pageColor: Colors.lightGreenAccent,
      title: const Text('Predict problems'),
      body: const Text(
        'Receive alerts and apply preventative measures ',
        style: TextStyle(color: Colors.black),
      ),
      bodyTextStyle: const TextStyle(color: Colors.black),
      titleTextStyle: const TextStyle(color: Colors.black),
    ),
    PageViewModel(
      mainImage: Image.asset('assets/intro2.png'),
      pageColor: Colors.greenAccent,
      bubble: Image.asset('assets/tm.png'),
      title: const Text('Community'),
      body: const Text('Exchange insights with colleagues and experts'),
      bodyTextStyle: const TextStyle(color: Colors.black),
      titleTextStyle: const TextStyle(color: Colors.black),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          background: Colors.white,
          showBackButton: true,
          showNextButton: true,
          showSkipButton: true,
          skipText: const Text(
            'SKIP',
            style: TextStyle(color: Colors.black),
          ),
          doneText: const Text(
            'DONE',
            style: TextStyle(color: Colors.black),
          ),
          backText: const Text(
            'BACK',
            style: TextStyle(color: Colors.black),
          ),
          nextText: const Text(
            'NEXT',
            style: TextStyle(color: Colors.black),
          ),
          onTapDoneButton: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
          },
          onTapSkipButton: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
