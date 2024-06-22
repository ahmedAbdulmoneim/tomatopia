import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tomatopia/page_transitions/scale_transition.dart';

import 'filed_monotoring.dart';

class Alerts extends StatefulWidget {
  const Alerts({Key? key}) : super(key: key);

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {

        AwesomeDialog(
          context: context,
          body: Text('${message.notification!.title} :  ${message.notification!.body}'),
          dialogType: DialogType.warning,
        ).show();
      }
    });
    FirebaseMessaging.instance.getInitialMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('pests'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Text(
              'notification_message'.tr(),
              style: const TextStyle(fontSize: 16),
            ),
            Image.asset(
              'assets/n.png',
              height: 150,
            ), // Replace with your image asset
            Row(
              children: [
                const Icon(Icons.lightbulb, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'prevention_tip'.tr(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'field_monitoring'.tr(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'catch_early'.tr(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Image.asset(
              'assets/monitoring.png',
              width: double.infinity,
              fit: BoxFit.contain,
            ), // Replace with your image asset
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    textStyle: MaterialStateTextStyle.resolveWith(
                            (states) => const TextStyle(
                          color: Colors.black,
                        )),
                    elevation:
                    MaterialStateProperty.resolveWith((states) => .3),
                    backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.greenAccent)),
                onPressed: () {
                  // Implement your functionality here
                  Navigator.push(context, ScaleTransition1(FiledMonitoring()));
                },
                child: Text('learn_more'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
