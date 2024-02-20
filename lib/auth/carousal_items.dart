import 'package:flutter/material.dart';

final List<Widget> carousalItems = [
  Stack(
    alignment: Alignment.bottomLeft,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/tomato_leaf/healthy.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Healthy',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black
        ),),
      ),
    ],
  ),
  Stack(
    alignment: Alignment.bottomLeft,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/tomato_leaf/early.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Early blight',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black
        ),),
      ),
    ],
  ),
  Stack(
    alignment: Alignment.bottomLeft,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/tomato_leaf/late.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Late blight',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black
          ),),
      ),
    ],
  ),
  Stack(
    alignment: Alignment.bottomLeft,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/tomato_leaf/bacterial.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Bacterial spot',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black
          ),),
      ),
    ],
  ),
  Stack(
    alignment: Alignment.bottomLeft,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/tomato_leaf/mold.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Leaf Mold',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black
          ),),
      ),
    ],
  ),
  Stack(
    alignment: Alignment.bottomLeft,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/tomato_leaf/mosaic_virus.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Mosaic virus',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black
          ),),
      ),
    ],
  ),
  Stack(
    alignment: Alignment.bottomLeft,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/tomato_leaf/septoria.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Septoria leaf spot',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black
          ),),
      ),
    ],
  ),
  Stack(
    alignment: Alignment.bottomLeft,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/tomato_leaf/spider.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Spider mites',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black
          ),),
      ),
    ],
  ),
  Stack(
    alignment: Alignment.bottomLeft,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/tomato_leaf/target_spot.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Target Spot',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black
          ),),
      ),
    ],
  ),
  Stack(
    alignment: Alignment.bottomLeft,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/tomato_leaf/yellow_leaf.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Yellow Leaf Curl Virus',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black
          ),),
      ),
    ],
  ),

];
