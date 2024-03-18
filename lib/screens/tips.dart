import 'package:flutter/material.dart';

class Tips extends StatelessWidget {
  const Tips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text('Tips'),
        ),
      ],
    ));
  }
}
