import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/auth/forget_password/verify.dart';
import 'package:tomatopia/cubit/auth_cubit/forget_password/forget_password_cubit.dart';
import 'package:tomatopia/cubit/auth_cubit/forget_password/forget_password_states.dart';
import 'package:tomatopia/custom_widget/custom_button.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';

class EmailChecking extends StatelessWidget {
  EmailChecking({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Forget Password',
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
          listener: (context, state) {
            if (state is ForgetPasswordSuccessState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VerifyCode(),
                  ));
            }
            if (state is ForgetPasswordFailuerState) {
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
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'CHECK EMAIL',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Please Enter Your Email Address To Receive Verification Code ',
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
                      onSaved: (value) {},
                      label: 'enter your email',
                      prefix: Icons.email_outlined,
                      validate: (value) {
                        if (value.toString().isEmpty) {
                          return 'enter an email to get code';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController),
                  const SizedBox(
                    height: 20,
                  ),
                  ConditionalBuilder(
                    condition: state is! ForgetPasswordLoadingState,
                    builder: (context) => customButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await BlocProvider.of<ForgetPasswordCubit>(context)
                                .checkEmail(email: emailController.text);
                          }
                        },
                        text: 'Get Code'),
                    fallback: (context) => Center(
                        child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.green,
                      size: 50,
                    )),
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
