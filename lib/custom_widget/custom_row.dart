import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customRow({
  required double width,
  required IconData icon,
  required String text
}) => Row(
  children: [
    Icon(icon),
    SizedBox(
      width: width,
    ),
    Text(text)
  ],
);