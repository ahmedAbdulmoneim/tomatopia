import 'package:flutter/material.dart';
import 'package:tomatopia/custom_widget/custom_row.dart';

Widget communityCard() => Card(
    shadowColor: Colors.grey,
    elevation: 2,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/ahmed.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Ahmed',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Egypt',
                        style: TextStyle(color: Colors.black54),
                      )
                    ],
                  ),
                  Text(
                    '28 Dec, 22',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
              'I got this problem in my plant, why this happened adn how can I treat this '),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/real_tomato.png',
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                    child: customRow(
                        width: 5,
                        icon: Icons.thumb_up_outlined,
                        text: 'Upvote')),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                    child: customRow(
                        width: 5,
                        icon: Icons.thumb_down_outlined,
                        text: 'Dnvote')),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                    child: customRow(
                        width: 5, icon: Icons.comment, text: 'Comment')),
              ),
            ],
          )
        ],
      ),
    ));
