import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:tomatopia/auth/login.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);
  final pages = [
    PageModel.withChild(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Take a photo',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    decoration: TextDecoration.none,
                    color: Colors.black),
              ),
              Image.asset('assets/scan.png', width: 300.0, height: 300.0),
              const Text(
                'Receive instant identifications and treatment suggestions',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        color: Colors.white,
        doAnimateChild: true),
    PageModel.withChild(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Search',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    decoration: TextDecoration.none,
                    color: Colors.black),
              ),
              Image.asset('assets/search.png', width: 300.0, height: 300.0),
              const Text(
                'Search for what you need',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        color: Colors.white,
        doAnimateChild: true),
    PageModel.withChild(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Predict problems',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    decoration: TextDecoration.none,
                    color: Colors.black),
              ),
              Image.asset('assets/alert.png', width: 300.0, height: 300.0),
              const Text(
                'Receive alerts and apply preventative measures',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        color: Colors.white,
        doAnimateChild: true),
    PageModel.withChild(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Treatment',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    decoration: TextDecoration.none,
                    color: Colors.black),
              ),
              Image.asset('assets/treatment.jpg', width: 300.0, height: 300.0),
              const Text(
                'Get the best treatment for your plant',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        color: Colors.white,
        doAnimateChild: true),
    PageModel.withChild(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Community',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    decoration: TextDecoration.none,
                    color: Colors.black),
              ),
              Image.asset('assets/cmmunity.png', width: 300.0, height: 300.0),
              const Text(
                'Supportive Farming Community',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        color: Colors.white,
        doAnimateChild: true),
  ];

  @override
  Widget build(BuildContext context) {
    return OverBoard(
      pages: pages,
      allowScroll: true,
      inactiveBulletColor: Colors.grey,
      activeBulletColor: Colors.greenAccent,
      finishCallback: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      },
      showBullets: true,
      skipCallback: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      },
      skipText: 'SKIP',
      finishText: 'DONE',
      nextText: 'NEXT',
      buttonColor: Colors.black,
    );
  }
}
