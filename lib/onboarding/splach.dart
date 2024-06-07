import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'onboarding.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('assets/tomato3.png'),
          TyperAnimatedTextKit(
            // colors: const [
            //   Colors.red,
            //   Colors.red,
            //   Colors.yellow,
            //   Colors.lightGreenAccent,
            //   Color(0xFF4a8d3d),
            //   Color(0xFF4a8d3d),
            //   Colors.green
            // ],
            totalRepeatCount: 1,
            speed: const Duration(milliseconds: 80),
            text: const ['WELCOME TO ', 'TOMATOPIA', 'TOMATOPIA'],
            textStyle: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.red),
          ),
        ],
      ),
      nextScreen: OnBoarding(),
      splashIconSize: 250,
      curve: Curves.easeOutSine,
      pageTransitionType: PageTransitionType.bottomToTop,
      splashTransition: SplashTransition.sizeTransition,
      animationDuration: const Duration(milliseconds: 1000),
      duration: 3500,
    );
  }
}
