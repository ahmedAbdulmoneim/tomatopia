import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/custom_widget/custom_row.dart';

import '../cubit/home_cubit/home_cubit.dart';

Widget communityCard(
        {required String postImage,
        required String content,
        required int likes,
        required int dislikes,
        required int id,
        required int index,
        context}) =>
    Card(
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
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
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
              Text(content),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  postImage,
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).width,
                  height: 300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<HomeCubit>(context).addReactToPost(
                        id: id,
                        like: true,
                        dislike: false,
                        index: index

                      );
                      // BlocProvider.of<HomeCubit>(context).onLikeTaped();
                    },
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20)),
                        child: customRow(
                            width: 5,
                            icon: Icons.thumb_up_outlined,
                            text: BlocProvider.of<HomeCubit>(context).reactModel != null && BlocProvider.of<HomeCubit>(context).reactModel!.id == id ?
                            '${BlocProvider.of<HomeCubit>(context).reactModel!.likes}' : '$likes'
                        )),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<HomeCubit>(context).addReactToPost(
                        id: id,
                        like: false,
                        dislike: true,
                          index: index
                      );
                      // BlocProvider.of<HomeCubit>(context).onDisLikeTaped();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)),
                      child: customRow(
                        width: 5,
                        icon: Icons.thumb_down_outlined,
                        text: BlocProvider.of<HomeCubit>(context).reactModel?.id == id ?
                            '${BlocProvider.of<HomeCubit>(context).reactModel!.disLikes}' : '$dislikes'
                      ),
                    ),
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
