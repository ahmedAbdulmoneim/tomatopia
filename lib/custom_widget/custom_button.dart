import 'package:flutter/material.dart';

Widget customButton({
  required String text,
  required onPressed,
  double? width,
}) =>
    MaterialButton(
      color: Colors.green,
      minWidth: width ?? double.infinity,
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
