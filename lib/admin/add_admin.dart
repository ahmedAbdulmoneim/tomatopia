import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_states.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'package:tomatopia/custom_widget/toasts.dart';

import '../custom_widget/custom_button.dart';
import '../custom_widget/text_form_filed.dart';


class AddAdmin extends StatelessWidget {
  AddAdmin({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.addAdmin),
          centerTitle: true,
        ),
        body: BlocConsumer<AdminCubit, AdminStates>(
          listener: (context, state) {
            if (state is AddAdminSuccessState) {
              show(context, context.done, context.addAdminSuccess, Colors.green);
              Navigator.pop(context);
            }
            if (state is AddAdminFailureState) {
              Fluttertoast.showToast(
                msg: context.pleaseVerifyInformation,
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 5,
                textColor: Colors.white,
                fontSize: 16.5,
                gravity: ToastGravity.CENTER,
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      context.addNewAdmin,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    context.enterEmailForNewAdmin,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 30),
                  textFormField(
                    onSaved: (value) {},
                    label: context.enterEmail,
                    prefix: Icons.email_outlined,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return context.enterEmail;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),
                  ConditionalBuilder(
                    condition: state is! AddAdminLoadingState,
                    builder: (context) => customButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await BlocProvider.of<AdminCubit>(context)
                              .addAdmin(email: emailController.text);
                        }
                      },
                      text: context.addNewAdmin,
                    ),
                    fallback: (context) => Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                        color: Colors.green,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
