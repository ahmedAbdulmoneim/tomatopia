import 'package:flutter/material.dart';

Widget dailyWeather() => Container(
  padding: const EdgeInsets.only(left: 20, right: 10),
  height: 100,
  decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(50),
    border: const Border(
      top: BorderSide(
        color: Colors.black,
        width: 2,
        strokeAlign: 1,
      ),
      bottom: BorderSide(
        color: Colors.black,
        width: 3,
        strokeAlign: 1,
      ),
    ),
  ),
  child: const Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '5 Mar',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          Text(
            'Clear . 24 °C / 20 °C',
          )
        ],
      ),
      Spacer(),
      Text(
        '24 °C ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Icon(
        Icons.sunny,
        color: Colors.yellow,
        size: 50,
      )
    ],
  ),
);