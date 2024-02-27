import 'package:flutter/material.dart';
import 'package:tomatopia/custom_widget/community_card.dart';

class Community extends StatelessWidget {
  const Community({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          body: ListView.builder(
              itemBuilder: (context, index) => communityCard(),
              itemCount: 20)),
    );
  }
}
