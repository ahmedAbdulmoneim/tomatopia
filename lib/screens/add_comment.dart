import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/home_cubit/home_states.dart';
import 'package:tomatopia/custom_widget/toasts.dart';

import '../cubit/home_cubit/home_cubit.dart';
import '../custom_widget/custom_row.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({
    super.key,
    required this.postIndex,
    required this.imagePost,
    required this.postContent,
    required this.id
  });

  final TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final int postIndex;
  final String imagePost;
  final String postContent;
  final int id ;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: BlocConsumer<HomeCubit,HomePageStates>(
          listener: (context, state) {print(state);
            if(state is AddCommentSuccessState){
              commentController.clear();
              BlocProvider.of<HomeCubit>(context).clearPostImage();
              show(context, 'Done', 'comment added successfully', Colors.green);
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent, // Scroll to the very bottom
                duration: const Duration(milliseconds: 300), // Animation duration
                curve: Curves.easeOut, // Animation easing
              );
            }
          },
          builder: (context, state) {
            var cubit = BlocProvider.of<HomeCubit>(context);
            var comments =
                cubit.allPosts[postIndex].comments;
            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 350,
                        pinned: true,
                        title: const SliverAppBarTitle(
                          child: Text(
                            'Comments',
                            style: TextStyle(color: Colors.black),
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    postContent,
                                    style: const TextStyle(fontSize: 16.0),
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
                              condition: comments.isNotEmpty,
                              builder: (context) => ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => const Divider(
                                  height: 20,
                                  thickness: 5,
                                ),
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  var comment = comments[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                comment.userImage != '' && comment.userImage.isNotEmpty
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
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.green,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                Text(
                                                  DateFormat("d MMM ").format(
                                                      DateTime.parse(
                                                          comment.creationDate)),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          comment.content,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (comment.image != null &&
                                            comment.image!.isNotEmpty)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: Image.network(
                                              '$basUrlImage${comment.image}',
                                              fit: BoxFit.cover,
                                              width:
                                              MediaQuery.of(context).size.width,
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
                                                // Add your like functionality here
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                    BorderRadius.circular(20)),
                                                child: customRow(
                                                    width: 5,
                                                    icon: Icons.thumb_up_outlined,
                                                    text: 'likes'),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // Add your dislike functionality here
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                    BorderRadius.circular(20)),
                                                child: customRow(
                                                    width: 5,
                                                    icon: Icons.thumb_down_outlined,
                                                    text: 'dislikes'),
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
                                  padding: const EdgeInsets.only(top: 70),
                                  child: Image.asset('assets/nocomment(1).jpg',height: 100,width: 100,)
                              ),
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "write comment to send it";
                            }
                            return null;
                          },
                          controller: commentController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.attach_file_outlined),
                              onPressed: () async {
                                await cubit.picImageFromGallery();
                              },
                            ),
                            labelText: 'Write a comment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          formKey.currentState!.save();
                          if(formKey.currentState!.validate()){
                            cubit.addCommentToPost(postId: id, content: commentController.text,imageFile: cubit.imageFile);
                          }
                          // Add your send comment functionality here
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
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

