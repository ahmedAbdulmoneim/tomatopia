import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/material.dart';

void show(BuildContext context,String title,String subTitle,Color color) {
  AchievementView(
    duration: const Duration(seconds: 2),
    color: color,
    title: title,
    subTitle: subTitle,
    isCircle: true,
    listener: print,
    alignment: Alignment.center,
    typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
  ).show(context);
}