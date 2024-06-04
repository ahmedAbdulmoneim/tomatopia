import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_states.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';
import 'package:tomatopia/custom_widget/toasts.dart';

class EditTreatment extends StatelessWidget {
  EditTreatment({super.key,required this.description,required this.title,required this.id});

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
        if(state is EditTreatmentSuccessState){
          show(context, 'Done!', 'Treatment Edited successfully', Colors.green);
          BlocProvider.of<AdminCubit>(context).getAllTreatment();
          titleController.clear();
          descriptionController.clear();
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

                          adminCubit.editTreatment(
                            id: id,
                            name: titleController.text,
                            description: descriptionController.text,
                          );

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
                      label: 'Enter treatment title',
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
                        hintText: 'Write a description for your treatment',
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
