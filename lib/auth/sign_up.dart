import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/cubit/auth_cubit/register/register_cubit.dart';

import '../cubit/auth_cubit/register/register_states.dart';
import '../custom_widget/custom_button.dart';
import '../custom_widget/text_form_filed.dart';
import '../screens/home.dart';
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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ));
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
                                return "Password is required";
                              }
                            },
                            onSaved: (value) {},
                            prefix: Icons.password,
                            suffix: Icons.visibility_off_outlined,
                            label: 'Password ',
                            obscureText: true,
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
                            suffix: Icons.visibility_off_outlined,
                            label: 'Confirm Password',
                            obscureText: true,
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
