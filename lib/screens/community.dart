import 'package:flutter/material.dart';
import 'package:tomatopia/custom_widget/community_card.dart';

import '../custom_widget/search_box.dart';

class Community extends StatelessWidget {
  const Community({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              children: [
                searchBox(),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) => communityCard(),
                      itemCount: 20),
                ),
              ],
            ),
          )),
    );
  }
}
