import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tomatopia/custom_widget/custom_row.dart';

import '../cubit/home_cubit/home_cubit.dart';

Widget communityCard(
        {required String postImage,
        required String content,
        required int likes,
        required int dislikes,
        required int id,
        required String userImageInPost,
        required String userNameInPost,
        required String creationDate,
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
               Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: BlocProvider.of<HomeCubit>(context).allPosts[index].userImage == "" ?const AssetImage('assets/no_profile_image.png') : NetworkImage(userImageInPost)as ImageProvider,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userNameInPost,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600),
                      ),
                       Text(
                        DateFormat("d MMM yyy").format(DateTime.parse(creationDate)),
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
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
                child: postImage != '' ?
                Image.network(
                  postImage,
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).width,
                  height: 300,
                ) :
                const Text(
                    '',
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
