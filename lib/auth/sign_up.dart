import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/constant/validate_password.dart';
import 'package:tomatopia/cubit/auth_cubit/register/register_cubit.dart';

import '../constant/constant.dart';
import '../cubit/auth_cubit/register/register_states.dart';
import '../custom_widget/custom_button.dart';
import '../custom_widget/text_form_filed.dart';
import '../screens/home.dart';
import '../shared_preferences/shared_preferences.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(TomatopiaServices(Dio())),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Fluttertoast.showToast(
                msg: 'account created successfully',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.green,
                timeInSecForIosWeb: 5,
                textColor: Colors.white,
                fontSize: 16.5,
                gravity: ToastGravity.CENTER);
            SharedPreference.saveData(key: 'token', value: BlocProvider.of<RegisterCubit>(context).loginModel!.token).then((value) {
              token = BlocProvider.of<RegisterCubit>(context).loginModel!.token;
            });
            SharedPreference.saveData(key: 'userName', value: BlocProvider.of<RegisterCubit>(context).loginModel!.name).then((value) {
              userName = BlocProvider.of<RegisterCubit>(context).loginModel!.name;

            });
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ));
          }
          if (state is RegisterFailureState) {
            Fluttertoast.showToast(
                msg: 'Oops! Something went wrong while creating your account. Please try again',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 5,
                textColor: Colors.white,
                fontSize: 16.5,
                gravity: ToastGravity.CENTER);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Form(
              key: formKey,
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image.asset(
                                'assets/tomato4.png',
                              ),
                              const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 25),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          textFormField(
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "Name is required";
                                }
                              },
                              controller: nameController,
                              prefix: Icons.person,
                              label: 'Full Name ',
                              keyboardType: TextInputType.name,
                              onSaved: (value) {}),
                          const SizedBox(
                            height: 10,
                          ),
                          textFormField(
                            controller: emailController,
                            validate: (value) {
                              if (value.isEmpty) {
                                return "Email is required";
                              }
                            },
                            onSaved: (value) {},
                            prefix: Icons.alternate_email_rounded,
                            label: 'Email address',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          textFormField(
                            controller: passwordController,
                            validate: (value) {
                              if (value.isEmpty) {
                                return "password can't be empty";
                              }
                              return validatePassword(value);
                            },
                            onSaved: (value) {},
                            prefix: Icons.password,
                            suffix:  BlocProvider.of<RegisterCubit>(context).suffix,
                            label: 'Password ',
                            obscureText: BlocProvider.of<RegisterCubit>(context).isSecure,
                            suffixFunc: BlocProvider.of<RegisterCubit>(context).changePasswordVisibility,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          textFormField(
                            controller: confirmPasswordController,
                            validate: (value) {
                              if (value.isEmpty) {
                                return "Password is required";
                              }
                              return validatePassword(value);
                            },
                            onSaved: (value) {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(context)
                                    .register(
                                        endPoint: registerEndpoint,
                                        data: {
                                      'fullName': nameController.text,
                                      'email': emailController.text,
                                      'password': passwordController.text,
                                      'confirmPassword':
                                          confirmPasswordController.text,
                                    });
                              }
                            },
                            prefix: Icons.password,
                            suffix: BlocProvider.of<RegisterCubit>(context).suffix,
                            label: 'Confirm Password',
                            obscureText: BlocProvider.of<RegisterCubit>(context).isSecure,
                            suffixFunc: BlocProvider.of<RegisterCubit>(context).changePasswordVisibility,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => customButton(
                                text: 'SIGN UP',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<RegisterCubit>(context)
                                        .register(
                                            endPoint: registerEndpoint,
                                            data: {
                                          'fullName': nameController.text,
                                          'email': emailController.text,
                                          'password': passwordController.text,
                                          'confirmPassword':
                                              confirmPasswordController.text,
                                        });
                                  }
                                }),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Text("Already  have an account "),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ));
                                  },
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
