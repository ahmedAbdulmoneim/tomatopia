import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/custom_widget/custom_row.dart';
import 'package:tomatopia/page_transitions/scale_transition.dart';
import 'package:tomatopia/screens/edit_post.dart';
import '../cubit/home_cubit/home_cubit.dart';
import '../screens/add_comment.dart';
import 'package:tomatopia/custom_widget/extensions.dart'; // Ensure to import the extension

Widget communityCard(
    {required String postImage,
      required String content,
      required int likes,
      required int dislikes,
      required int id,
      required String userImageInPost,
      required String userNameInPost,
      required String creationDate,
      required String userIdPost,
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
                    backgroundImage: userImageInPost == "" ? NetworkImage(noImage) : NetworkImage(userImageInPost),
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
                  ),
                  const Spacer(),
                  isAdmin == true && userId != userIdPost ?
                  PopupMenuButton(
                    icon: const Icon(Icons.more_horiz),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: customRow(width: 5, icon: Icons.delete, text: context.deletePost),
                        onTap: (){
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            btnOkOnPress: () async {
                              await BlocProvider.of<HomeCubit>(context).deletePost(id: id);
                            },
                            btnCancelOnPress: () {},
                            btnCancelText: context.cancel,
                            btnOkText: context.delete,
                            btnCancelColor: Colors.green,
                            btnOkColor: Colors.red,
                            title: context.deletePostConfirmation,
                            animType: AnimType.leftSlide,
                          ).show();
                        },
                      ),
                    ],
                  ):
                  const SizedBox() ,
                  userId == userIdPost || (isAdmin == true && userId == userIdPost) ?
                  PopupMenuButton(
                    icon: const Icon(Icons.more_horiz),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: customRow(width: 5, icon: Icons.edit, text: context.editPost),
                        onTap: (){
                          Navigator.push(context, ScaleTransition1(EditPost(
                            id: id,
                            oldContent: content,
                            oldImage: postImage,
                          ),
                          ),
                          );
                        },
                      ),
                      PopupMenuItem(
                        child: customRow(width: 5, icon: Icons.delete, text: context.deletePost),
                        onTap: (){
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            btnOkOnPress: () async {
                              await BlocProvider.of<HomeCubit>(context).deletePost(id: id);
                            },
                            btnCancelOnPress: () {},
                            btnCancelText: context.cancel,
                            btnOkText: context.delete,
                            btnCancelColor: Colors.green,
                            btnOkColor: Colors.red,
                            title: context.deletePostConfirmation,
                            animType: AnimType.leftSlide,
                          ).show();
                        },
                      ),
                    ],
                  ):
                  const SizedBox() ,

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

                      );
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
                          text:  BlocProvider.of<HomeCubit>(context).reactModel != null && BlocProvider.of<HomeCubit>(context).reactModel?.id == id ?
                          '${BlocProvider.of<HomeCubit>(context).reactModel!.disLikes}' : '$dislikes'
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async{
                      await BlocProvider.of<HomeCubit>(context).getPostComments(id: id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CommentScreen(id: id,imagePost: postImage,postContent: content,)),
                      );
                    },
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20)),
                        child: customRow(
                            width: 5, icon: Icons.comment, text: '${BlocProvider.of<HomeCubit>(context).allPosts[index].comments}')),
                  ),
                ],
              )
            ],
          ),
        ));
