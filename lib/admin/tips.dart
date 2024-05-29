import 'package:flutter/material.dart';

class Tips extends StatelessWidget {
  const Tips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tips',
            style: TextStyle(
              fontSize: 25,
            ),),

        ],
      ),
    );
  }
}
