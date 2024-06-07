import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/home_cubit/home_states.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'package:tomatopia/custom_widget/toasts.dart';
import 'package:tomatopia/screens/edit_comment.dart';

import '../cubit/home_cubit/home_cubit.dart';
import '../custom_widget/custom_row.dart';
import '../page_transitions/scale_transition.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({
    super.key,
    required this.imagePost,
    required this.postContent,
    required this.id,
  });

  final TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final String imagePost;
  final String postContent;
  final int id;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: BlocConsumer<HomeCubit, HomePageStates>(
          listener: (context, state) {
            if (state is AddCommentSuccessState) {
              commentController.clear();
              BlocProvider.of<HomeCubit>(context).clearPostImage();
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                // Scroll to the very bottom
                duration:  const Duration(milliseconds: 300),
                // Animation duration
                curve: Curves.easeOut, // Animation easing
              );
              BlocProvider.of<HomeCubit>(context).getPostComments(id: id);
            }
            else if(state is DeleteCommentSuccessState){
              show(context, context.done, context.commentDeletedSuccessfully, Colors.green);
              BlocProvider.of<HomeCubit>(context).getPostComments(id: id);
            }
          },
          builder: (context, state) {
            var cubit = BlocProvider.of<HomeCubit>(context);
            return ConditionalBuilder(
                condition: state is GetAllPostCommentsLoadingState,
                builder: (context) => Center(child: LoadingAnimationWidget.prograssiveDots(color: Colors.green, size: 50),),
                fallback: (context) => Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          SliverAppBar(
                            expandedHeight: 350,
                            pinned: true,
                            title:  SliverAppBarTitle(
                              child: Text(
                                context.comments,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            flexibleSpace: FlexibleSpaceBar(
                              background: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    imagePost != '' ? imagePost : noImage,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 200.0,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:  const EdgeInsets.all(8.0),
                                      child: Text(
                                        postContent,
                                        style:  const TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                 const Divider(
                                  thickness: 5,
                                ),
                                ConditionalBuilder(
                                  condition: cubit.commentPostList.isNotEmpty,
                                  builder: (context) => ListView.separated(
                                    shrinkWrap: true,
                                    physics:  const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                     const Divider(
                                      height: 20,
                                      thickness: 5,
                                    ),
                                    itemCount: cubit.commentPostList.length,
                                    itemBuilder: (context, index) {
                                      var comment = cubit.commentPostList[index];
                                      return Padding(
                                        padding:  const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: NetworkImage(
                                                    comment.userImage != null

                                                        ? '$basUrlImage${comment.userImage}'
                                                        : noImage,
                                                  ),
                                                ),
                                                 const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      comment.userName,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style:  const TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    ),
                                                    Text(
                                                      DateFormat("d MMM ").format(
                                                          DateTime.parse(comment.creationDate)),
                                                      style:  const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                                 const Spacer(),
                                                userId == comment.userId ?
                                                PopupMenuButton(
                                                  icon:  const Icon(Icons.more_horiz),
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      child: customRow(width: 5, icon: Icons.edit, text: context.editComment),
                                                      onTap: (){
                                                        Navigator.push(context, ScaleTransition1(EditComment(
                                                          commentId: comment.id,
                                                          postId: id,
                                                          oldContent: comment.content,
                                                          oldImage: comment.image != null ? '$basUrlImage${comment.image!}' : '',
                                                        ),
                                                        ),
                                                        );
                                                      },
                                                    ),
                                                    PopupMenuItem(
                                                      child: customRow(width: 5, icon: Icons.delete, text: context.deleteComment),
                                                      onTap: (){
                                                        AwesomeDialog(
                                                          context: context,
                                                          dialogType: DialogType.warning,
                                                          btnOkOnPress: (){
                                                            cubit.deleteComment(id: comment.id);
                                                          },
                                                          btnCancelOnPress: () {},
                                                          btnCancelText: context.cancel,
                                                          btnOkText: context.delete,
                                                          btnCancelColor: Colors.green,
                                                          btnOkColor: Colors.red,
                                                          title:
                                                          context.areYouSureToDelete,
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
                                              height: 20,
                                            ),
                                            Text(
                                              comment.content,
                                              style:  const TextStyle(fontSize: 18),
                                            ),
                                             const SizedBox(
                                              height: 10,
                                            ),
                                            if (comment.image != null &&
                                                comment.image!.isNotEmpty)
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                child: Image.network(
                                                  '$basUrlImage${comment.image}',
                                                  fit: BoxFit.cover,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                ),
                                              ),
                                             const Divider(
                                              endIndent: 10,
                                              indent: 10,
                                            ),
                                             const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    cubit.addReactToComment(
                                                        id: comment.id,
                                                        like: true,
                                                        dislike: false
                                                    );
                                                    // Add your like functionality here
                                                  },
                                                  child: Container(
                                                    padding:  const EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 5,
                                                        bottom: 5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                    child: customRow(
                                                        width: 5,
                                                        icon:
                                                        Icons.thumb_up_outlined,
                                                        text: cubit.commentReactModel != null && comment.id == cubit.commentReactModel!.id ?
                                                        '${cubit.commentReactModel!.likes}'
                                                            :'${comment.likes}'
                                                    ),
                                                  ),
                                                ),
                                                 const SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    cubit.addReactToComment(
                                                        id: comment.id,
                                                        like: false,
                                                        dislike: true);
                                                    // Add your dislike functionality here
                                                  },
                                                  child: Container(
                                                    padding:  const EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 5,
                                                        bottom: 5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        20,),),
                                                    child: customRow(
                                                        width: 5,
                                                        icon: Icons.thumb_down_outlined,
                                                        text: cubit.commentReactModel != null && comment.id == cubit.commentReactModel!.id ?
                                                        '${cubit.commentReactModel!.disLikes}'
                                                            :'${comment.disLikes}'
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  fallback: (context) => Padding(
                                      padding:  const EdgeInsets.only(top: 70),
                                      child: Image.asset(
                                        'assets/nocomment(1).jpg',
                                        height: 100,
                                        width: 100,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:  const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return context.writeCommentToSend;
                                }
                                return null;
                              },
                              controller: commentController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon:  const Icon(Icons.attach_file_outlined),
                                  onPressed: () async {
                                    await cubit.picImageFromGallery();
                                  },
                                ),
                                labelText: context.writeAComment,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon:  const Icon(Icons.send),
                            onPressed: () {
                              formKey.currentState!.save();
                              if (formKey.currentState!.validate()) {
                                cubit.addCommentToPost(
                                    postId: id,
                                    content: commentController.text,
                                    imageFile: cubit.imageFile);
                              }
                              // Add your send comment functionality here
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),);
          },
        ),
      ),
    );
  }
}

class SliverAppBarTitle extends StatelessWidget {
  final Widget child;

   const SliverAppBarTitle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    final deltaExtent = settings!.maxExtent - settings.currentExtent;

    // Show the title only when the app bar is collapsed:
    return Opacity(
      opacity: (deltaExtent / settings.maxExtent),
      child: child,
    );
  }
}

