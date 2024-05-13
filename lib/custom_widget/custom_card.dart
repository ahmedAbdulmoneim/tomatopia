import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tomatopia/constant/variables.dart';

Widget card(
{
  required String image ,
  required int index ,
  required context,
  String? dialogTitle ,
  required String mainTitle,
  required String subtitle,
  onPressed,
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
              base64Decode('$image'),
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
          userEmail == 'admin@gamil.com' ?
          IconButton(
            onPressed: (){
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                btnOkOnPress: onPressed,
                btnCancelOnPress: () {},
                btnCancelText: 'Cancel',
                btnOkText: 'Delete',
                btnCancelColor: Colors.green,
                btnOkColor: Colors.red,
                title:
                dialogTitle,
                animType: AnimType.leftSlide,
              ).show();
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),) :
          const Icon(Icons.arrow_forward_ios_outlined)
        ],
      ),
    ),
  ),
);