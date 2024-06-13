import 'dart:convert';

import 'package:flutter/material.dart';

Widget customCard(
    {
      required String image ,
      required int index ,
      required context,
      String? dialogTitle ,
      required String mainTitle,
      required String subtitle,
    }
    ) => Card(
  elevation: 6,
  color: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  ),
  margin: const EdgeInsets.only(
      left: 15, right: 15, top: 8, bottom: 8),
  child: Container(
    height: 100,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              base64Decode(image),
              fit: BoxFit.fill,
              width: 70,
              height: 70,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.black54,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),

          const Icon(Icons.arrow_forward_ios_outlined)
        ],
      ),
    ),
  ),
);