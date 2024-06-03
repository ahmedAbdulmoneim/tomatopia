
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/cubit/home_cubit/home_cubit.dart';
import 'package:tomatopia/cubit/home_cubit/home_states.dart';
import 'package:tomatopia/custom_widget/toasts.dart';

class EditComment extends StatelessWidget {
  final int commentId;
  final int postId;
  final String oldContent;
  final String oldImage;

  EditComment({super.key,required this.postId, required this.commentId, required this.oldContent, required this.oldImage});

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    contentController.text = oldContent;

    return BlocConsumer<HomeCubit, HomePageStates>(
      listener: (context, state) {
        if (state is EditCommentSuccessState) {
          show(context, 'Done!', 'Comment edited successfully!', Colors.green);
          BlocProvider.of<HomeCubit>(context).clearPostImage();
          BlocProvider.of<HomeCubit>(context).getPostComments(id: postId);
          Navigator.pop(context);
        } else if (state is EditCommentFailureState) {
          show(context, 'Error', 'Error happened', Colors.red);
        }
        else if (state is DeleteCommentImageSuccessState) {
          show(context, 'Done!', 'Image Deleted successfully!', Colors.green);
          BlocProvider.of<HomeCubit>(context).clearPostImage();
          BlocProvider.of<HomeCubit>(context).getPostComments(id: postId);
          Navigator.pop(context);
        } else if (state is DeleteCommentImageFailureState) {
          show(context, 'Error', 'Error happened', Colors.red);
        }

      },
      builder: (context, state) {
        var homeCubit = BlocProvider.of<HomeCubit>(context);
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              elevation: 6,
              backgroundColor: Colors.white,
              title: const Text(
                'Edit Comment',
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        homeCubit.editComment(
                            content: contentController.text,
                            imageFile: homeCubit.imageFile,
                            id: commentId);
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ))
              ],
            ),
            body: ConditionalBuilder(
              condition: state is EditPostLoadingState,
              builder: (context) => Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      color: Colors.green, size: 50)),
              fallback: (context) => Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
                child: ListView(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Description can't be empty";
                        }
                        return null;
                      },
                      maxLength: 300,
                      maxLines: 8,
                      enableInteractiveSelection: true,
                      cursorColor: Colors.green,
                      controller: contentController,
                      decoration: const InputDecoration(
                        hintText: 'Write a comment',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    oldImage.isNotEmpty ?
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.attach_file_outlined,
                              size: 35,
                              color: Colors.blue,
                            ),
                            TextButton(
                              onPressed: () async {
                                await homeCubit.picImageFromGallery();
                              },
                              child: const Text(
                                'Edit Image',
                                style: TextStyle(fontSize: 20, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.delete,
                              size: 35,
                              color: Colors.blue,
                            ),
                            TextButton(
                              onPressed: () async {
                                homeCubit.removeCommentImage(id: commentId);
                              },
                              child: const Text(
                                'Remove Image',
                                style: TextStyle(fontSize: 20, color: Colors.blue),
                              ),
                            ),
                          ],
                        )
                      ],
                    ) :
                    Row(
                      children: [
                        const Icon(
                          Icons.attach_file_outlined,
                          size: 35,
                          color: Colors.blue,
                        ),
                        TextButton(
                          onPressed: () async {
                            await homeCubit.picImageFromGallery();
                          },
                          child: const Text(
                            'Add Image',
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    if (homeCubit.imageFile != null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                homeCubit.imageFile!,
                                fit: BoxFit.cover,
                                width: MediaQuery.sizeOf(context).width,
                                height: 300,
                              )
                          ),
                          IconButton(
                            onPressed: () {
                              homeCubit.clearPostImage();
                            },
                            icon: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black87,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
