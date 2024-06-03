import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_states.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';
import 'package:tomatopia/custom_widget/toasts.dart';

class EditTips extends StatelessWidget {
  EditTips({super.key,required this.description,required this.title,required this.id});

  String title;
  String description;
  int id ;
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context, state) {
        if(state is EditTipSuccessState){
          show(context, 'Done!', 'Tip Edited successfully', Colors.green);
          BlocProvider.of<AdminCubit>(context).getAllTips();
          titleController.clear();
          descriptionController.clear();
          BlocProvider.of<AdminCubit>(context).clearImage();
          Navigator.pop(context);
        }else if(state is EditTipFailureState){
          show(context, 'Error', 'Error happened', Colors.red);
        }

      },
      builder: (context, state) {
        var adminCubit = BlocProvider.of<AdminCubit>(context);
        titleController.text = title ;
        descriptionController.text = description ;
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              elevation: 6,
              backgroundColor: Colors.white,
              title: const Text(
                'Edit Tips',
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if(adminCubit.imageFile != null){
                          adminCubit.editTip(
                            id: id,
                            title: titleController.text,
                            description: descriptionController.text,
                            imageFile: adminCubit.imageFile,
                          );
                        }else{
                          show(context, 'Error ', 'Please select Image', Colors.red);
                        }

                      }
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ))
              ],
            ),
            body: ConditionalBuilder(
              condition: state is EditTipLoadingState,
              builder: (context) => Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      color: Colors.green, size: 50)),
              fallback: (context) => Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
                child: ListView(
                  children: [
                    textFormField(
                      validate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Title can't be empty";
                        }
                        return null;
                      },
                      prefix: Icons.title,
                      label: 'Enter tip title',
                      controller: titleController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Description can't be empty";
                        }
                        return null;
                      },
                      maxLines: 8,
                      enableInteractiveSelection: true,
                      cursorColor: Colors.green,
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Write a description for your Tip',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        errorStyle: TextStyle(color: Colors.red),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.attach_file_outlined,
                          size: 35,
                          color: Colors.blue,
                        ),
                        TextButton(
                          onPressed: () async {
                            await adminCubit.picImageFromGallery();
                          },
                          child: const Text(
                            'Add Image',
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    if (adminCubit.imageFile != null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              adminCubit.imageFile!,
                              fit: BoxFit.cover,
                              width: MediaQuery.sizeOf(context).width,
                              height: 300,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              adminCubit.clearImage();
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
                      )
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
