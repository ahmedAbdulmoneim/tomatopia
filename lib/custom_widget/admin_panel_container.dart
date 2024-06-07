import 'package:flutter/material.dart';

Widget containerPanel(text) => Container(
  height: 100,
  width: 320,
  decoration: const BoxDecoration(
    gradient: SweepGradient(
      colors: [
        Colors.lightBlueAccent,
        Colors.cyanAccent,
        Colors.blue,
        Colors.cyanAccent,
      ],
    ),
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(
          100,
        ),
        bottomRight: Radius.circular(100)),
    border: Border(
        left: BorderSide(color: Colors.black, width: 3),
        bottom: BorderSide(),
        right: BorderSide()),
  ),
  child: Center(
    child: Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
);
