import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/auth/login.dart';
import 'package:tomatopia/cubit/auth_cubit/forget_password/forget_password_cubit.dart';
import '../../constant/validate_password.dart';
import '../../cubit/auth_cubit/forget_password/forget_password_states.dart';
import '../../custom_widget/custom_button.dart';
import '../../custom_widget/text_form_filed.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset Password',
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            Fluttertoast.showToast(
                msg: 'Password Changed Successfully ',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.green,
                timeInSecForIosWeb: 5,
                textColor: Colors.white,
                fontSize: 16.5,
                gravity: ToastGravity.CENTER);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          }
          if (state is ResetPasswordFailuerState) {
            Fluttertoast.showToast(
                msg: 'email is not correct ',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 5,
                textColor: Colors.white,
                fontSize: 16.5,
                gravity: ToastGravity.CENTER);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<ForgetPasswordCubit>(context);
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text(
                      'NEW PASSWORD',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Please Enter Your New Password ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    textFormField(
                      validate: (value) {
                        if (value.isEmpty) {
                          return "password can't be empty";
                        }
                        return validatePassword(value);
                      },
                      onSaved: (value) {},
                      prefix: Icons.password,
                      label: 'New password ',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: cubit.isSecure,
                      suffix: cubit.suffix,
                      suffixFunc: cubit.changePasswordVisibility,
                      controller: newPasswordController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(
                      validate: (value) {
                        if (value.isEmpty) {
                          return "password can't be empty";
                        }
                        return validatePassword(value);
                      },
                      onSaved: (value) {},
                      prefix: Icons.password,
                      label: 'Confirm password ',
                      obscureText: cubit.isSecure,
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmNewPasswordController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: state is! ResetPasswordLoadingState,
                      builder: (context) => customButton(
                          text: 'Save',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (newPasswordController.text ==
                                  confirmNewPasswordController.text) {
                                cubit.resetPassword(
                                  newPassword: newPasswordController.text,
                                  confirmPassword:
                                      confirmNewPasswordController.text,
                                  email: cubit.forgetPasswordModel!.email!,
                                  resetPasswordToken:
                                      cubit.forgetPasswordModel!.token!,
                                );
                              } else if (newPasswordController.text !=
                                  confirmNewPasswordController.text) {
                                Fluttertoast.showToast(
                                    msg: 'passwords is not identical ',
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.red,
                                    timeInSecForIosWeb: 5,
                                    textColor: Colors.white,
                                    fontSize: 16.5,
                                    gravity: ToastGravity.CENTER);
                              }
                            }
                          }),
                      fallback: (context) => Center(
                        child: LoadingAnimationWidget.threeArchedCircle(
                          color: Colors.green,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
