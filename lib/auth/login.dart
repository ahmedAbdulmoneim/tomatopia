import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/constant/validate_password.dart';
import 'package:tomatopia/cubit/auth_cubit/login/login_cubit.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'package:tomatopia/shared_preferences/shared_preferences.dart';
import '../constant/variables.dart';
import '../cubit/auth_cubit/login/login_states.dart';
import '../custom_widget/custom_button.dart';
import '../custom_widget/text_form_filed.dart';
import '../screens/home.dart';
import 'forget_password/email_checking.dart';
import 'sign_up.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(TomatopiaServices(Dio())),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Fluttertoast.showToast(
              msg: context.loggingSuccessfully,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.green,
              timeInSecForIosWeb: 5,
              textColor: Colors.white,
              fontSize: 16.5,
              gravity: ToastGravity.CENTER,
            );
            SharedPreference.saveData(
              key: 'token',
              value: BlocProvider.of<LoginCubit>(context).loginModel!.token,
            ).then((value) {
              token = BlocProvider.of<LoginCubit>(context).loginModel!.token;
            });
            SharedPreference.saveData(
              key: 'userEmail',
              value: BlocProvider.of<LoginCubit>(context).loginModel!.email,
            ).then((value) {
              userEmail = BlocProvider.of<LoginCubit>(context).loginModel!.email;
            });
            SharedPreference.saveData(
              key: 'userName',
              value: BlocProvider.of<LoginCubit>(context).loginModel!.name,
            ).then((value) {
              userName = BlocProvider.of<LoginCubit>(context).loginModel!.name;
            });
            SharedPreference.saveData(
              key: 'userId',
              value: BlocProvider.of<LoginCubit>(context).loginModel!.userId,
            ).then((value) {
              userId = BlocProvider.of<LoginCubit>(context).loginModel!.userId!;
            });
            SharedPreference.saveData(
              key: 'userImage',
              value: BlocProvider.of<LoginCubit>(context).loginModel!.image ?? '',
            ).then((value) {
              userImage = BlocProvider.of<LoginCubit>(context).loginModel!.image ?? '';
            });
            SharedPreference.saveData(
              key: 'isAdmin',
              value: BlocProvider.of<LoginCubit>(context).loginModel!.isAdmin,
            ).then((value) {
              isAdmin = BlocProvider.of<LoginCubit>(context).loginModel!.isAdmin;
            });
            var fbm = FirebaseMessaging.instance;
            fbm.getToken().then((fcmToken) {
              if (fcmToken != null) {
                BlocProvider.of<LoginCubit>(context).addFcmToken(
                  userID:  BlocProvider.of<LoginCubit>(context).loginModel!.userId!,
                  fcmToken: fcmToken,
                );
              } else {
                debugPrint('Failed to get FCM token');
              }
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          }
          if (state is LoginFailureState) {
            Fluttertoast.showToast(
              msg: tr('please_verify_information'),
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
          return Form(
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
                            Lottie.asset('assets/sign_up.json',height: 300,width: 300),

                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              tr('login'),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        textFormField(
                          controller: emailController,
                          label: tr('email_address'),
                          keyboardType: TextInputType.emailAddress,
                          prefix: Icons.alternate_email,
                          validate: (value) {
                            if (value.isEmpty) {
                              return tr('email_is_required');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        textFormField(
                          controller: passwordController,
                          onSaved: (value) {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(context).login(
                                endPoint: loginEndpoint,
                                data: {
                                  'email': emailController.text,
                                  'password': passwordController.text,
                                },
                              );
                            }
                          },
                          label: tr('password'),
                          obscureText: BlocProvider.of<LoginCubit>(context).isSecure,
                          keyboardType: TextInputType.visiblePassword,
                          prefix: Icons.password,
                          suffix: BlocProvider.of<LoginCubit>(context).suffix,
                          suffixFunc: BlocProvider.of<LoginCubit>(context).changePasswordVisibility,
                          validate: (password) {
                            if (password.toString().isEmpty) {
                              return tr('password_cant_be_empty');
                            }
                            return validatePassword(password);
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmailChecking(),
                              ),
                            );
                          },
                          child: Text(
                            tr('forget_password'),
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => customButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await BlocProvider.of<LoginCubit>(context).login(
                                  endPoint: loginEndpoint,
                                  data: {
                                    'email': emailController.text,
                                    'password': passwordController.text,
                                  },
                                );
                                var fbm = FirebaseMessaging.instance;
                                 fbm.getToken().then((value) => {
                                  SharedPreference.saveData(
                                    key: userId,
                                    value: value,
                                  ).then((value) {
                                  })
                                });
                              }
                            },
                            text: tr('login_button'),
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(color: Colors.green),
                          ),
                        ),
                        Row(
                          children: [
                            Text(tr('dont_have_an_account')),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterPage()),
                                );
                              },
                              child: Text(
                                tr('sign_up_button'),
                                style: const TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ],
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
