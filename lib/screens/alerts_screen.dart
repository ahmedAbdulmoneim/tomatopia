import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../custom_widget/custom_button.dart';

class Alerts extends StatefulWidget {
  const Alerts({Key? key}) : super(key: key);

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  var userLocationLate = '';
  var userLocationLong = '';

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Handle the case where the user denies location access
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userLocationLate = position.latitude.toString();
    userLocationLong = position.longitude.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customButton(
              text: 'User Location',
              onPressed: () {
                getLocation();
              },
              width: double.infinity),
          const SizedBox(
            height: 20,
          ),
          Text(
            'late : $userLocationLate',
            style: const TextStyle(color: Colors.black54),
          ),
          Text(
            'long : $userLocationLong',
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
