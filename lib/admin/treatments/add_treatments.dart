import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_states.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';
import 'package:tomatopia/custom_widget/toasts.dart';

class AddTreatments extends StatelessWidget {
  AddTreatments({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context, state) {
        if(state is AddTreatmentSuccessState){
          show(context, context.done, context.treatmentAddedSuccessfully, Colors.green);
          BlocProvider.of<AdminCubit>(context).getAllTreatment();
          titleController.clear();
          descriptionController.clear();
          Navigator.pop(context);
        }else if(state is AddTreatmentFailureState){
          show(context, context.error, context.errorHappened, Colors.red);
        }

      },
      builder: (context, state) {
        var adminCubit = BlocProvider.of<AdminCubit>(context);
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              elevation: 6,
              backgroundColor: Colors.white,
              title:  Text(
                context.addTreatment,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                          adminCubit.addTreatment(
                            name: titleController.text,
                            description: descriptionController.text,
                          );
                      }
                    },
                    child:  Text(
                      context.save,
                      style: const TextStyle(color: Colors.green, fontSize: 18),
                    ))
              ],
            ),
            body: ConditionalBuilder(
              condition: state is AddTreatmentLoadingState,
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
                          return context.nameCantBeEmpty;
                        }
                        return null;
                      },
                      prefix: Icons.title,
                      label: context.enterTreatmentName,
                      controller: titleController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return context.descriptionCantBeEmpty;
                        }
                        return null;
                      },
                      maxLines: 8,
                      enableInteractiveSelection: true,
                      cursorColor: Colors.green,
                      controller: descriptionController,
                      decoration:  InputDecoration(
                        hintText: context.writeDescriptionForTreatment,
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        border: const OutlineInputBorder(),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        errorStyle: const TextStyle(color: Colors.red),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
