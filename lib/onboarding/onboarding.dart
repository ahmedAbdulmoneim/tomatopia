import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:tomatopia/auth/login.dart';
import 'package:tomatopia/shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);

  final pages = [
    PageModel.withChild(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "take_photo".tr(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/scan.png', width: 300.0, height: 300.0),
            const SizedBox(height: 20),
            Text(
              "receive_instant_identifications_and_treatment_suggestions".tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      color: Colors.white,
      doAnimateChild: true,
    ),
    PageModel.withChild(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "search".tr(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/search.png', width: 300.0, height: 300.0),
            const SizedBox(height: 20),
            Text(
              "search_for_disease_in_your_plant".tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      color: Colors.white,
      doAnimateChild: true,
    ),
    PageModel.withChild(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "predict_problems".tr(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/alert.png', width: 300.0, height: 300.0),
            const SizedBox(height: 20),
            Text(
              "receive_alerts_and_apply_preventative_measures".tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      color: Colors.white,
      doAnimateChild: true,
    ),
    PageModel.withChild(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "treatment".tr(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/treatment.jpg', width: 300.0, height: 300.0),
            const SizedBox(height: 20),
            Text(
              "get_the_best_treatment_for_your_plant".tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      color: Colors.white,
      doAnimateChild: true,
    ),
    PageModel.withChild(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "community".tr(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/cmmunity.png', width: 300.0, height: 300.0),
            const SizedBox(height: 20),
            Text(
              "supportive_farming_community".tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      color: Colors.white,
      doAnimateChild: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return OverBoard(
      pages: pages,
      allowScroll: true,
      inactiveBulletColor: Colors.grey,
      activeBulletColor: Colors.greenAccent,
      finishCallback: () {
        submit(context);
      },
      showBullets: true,
      skipCallback: () {
        submit(context);
      },
      skipText: "skip".tr(),
      finishText: "done".tr(),
      nextText: "next".tr(),
      buttonColor: Colors.black,
    );
  }
}

void submit(context) {
  SharedPreference.saveData(key: "onBoarding", value: 'done').then((value) {
    if (value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  });
}
