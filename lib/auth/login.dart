import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/auth/sign_up.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/cubit/auth_cubit/login/login_cubit.dart';

import '../cubit/auth_cubit/login/login_states.dart';
import '../custom_widget/custom_button.dart';
import '../custom_widget/text_form_filed.dart';
import '../screens/home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(TomatopiaServices(Dio())),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState){
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image.asset(
                                'assets/tomato1.png',
                              ),
                              const Text(
                                'Login',
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
                              controller: emailController,
                              label: 'Email address',
                              keyboardType: TextInputType.emailAddress,
                              prefix: Icons.alternate_email,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "email can't be empty";
                                }
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          textFormField(
                              controller: passwordController,
                              onSaved: (value) {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context).login(
                                      endPoint: loginEndpoint,
                                      data: {
                                        'email': emailController.text,
                                        'password': passwordController.text
                                      });
                                }
                              },
                              label: 'Password',
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              prefix: Icons.password,
                              suffix: Icons.visibility_off_outlined,
                              validate: (password) {
                                if (password.toString().isEmpty) {
                                  return "password can't be empty";
                                }
                              }),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forget Password',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => customButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await BlocProvider.of<LoginCubit>(context).login(
                                        endPoint: loginEndpoint,
                                        data: {
                                          'email': emailController.text,
                                          'password': passwordController.text
                                        });

                                  }
                                },
                                text: 'LOGIN'),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator(color: Colors.green,)),
                          ),
                          Row(
                            children: [
                              const Text("Don't have an account "),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegisterPage(),
                                        ));
                                  },
                                  child: const Text(
                                    'SIGN UP',
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
