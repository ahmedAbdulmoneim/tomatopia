import 'package:flutter/cupertino.dart';

class ScaleTransition1 extends PageRouteBuilder{
  final Widget page ;
  ScaleTransition1(this.page):super(
    pageBuilder: (context,animation,anotherAnimation) =>page,
    transitionDuration: const Duration(milliseconds: 1000),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context,animation,anotherAnimation,child){
      animation = CurvedAnimation(
          parent: animation,
          curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastOutSlowIn
      );
      return ScaleTransition(scale: animation,child: child,);
    },

  );


}