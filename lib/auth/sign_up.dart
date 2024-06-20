import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/constant/validate_password.dart';
import 'package:tomatopia/cubit/auth_cubit/register/register_cubit.dart';
import 'package:tomatopia/shared_preferences/shared_preferences.dart';
import '../constant/variables.dart';
import '../cubit/auth_cubit/register/register_states.dart';
import '../custom_widget/custom_button.dart';
import '../custom_widget/text_form_filed.dart';
import '../screens/home.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(TomatopiaServices(Dio())),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Fluttertoast.showToast(
              msg: tr('account_created_successfully'),
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.green,
              timeInSecForIosWeb: 5,
              textColor: Colors.white,
              fontSize: 16.5,
              gravity: ToastGravity.CENTER,
            );
            SharedPreference.saveData(key: 'token', value: BlocProvider.of<RegisterCubit>(context).registerModel!.token).then((value) {
              token = BlocProvider.of<RegisterCubit>(context).registerModel!.token!;
            });
            SharedPreference.saveData(
              key: 'userEmail',
              value: BlocProvider.of<RegisterCubit>(context).registerModel!.email,
            ).then((value) {
              userEmail = BlocProvider.of<RegisterCubit>(context).registerModel!.email!;
            });
            SharedPreference.saveData(
              key: 'userName',
              value: BlocProvider.of<RegisterCubit>(context).registerModel!.fullName!,
            ).then((value) {
              userName = BlocProvider.of<RegisterCubit>(context).registerModel!.fullName!;
            });
            SharedPreference.saveData(
              key: 'userId',
              value: BlocProvider.of<RegisterCubit>(context).registerModel!.userId,
            ).then((value) {
              userId = BlocProvider.of<RegisterCubit>(context).registerModel!.userId!;
            });
            SharedPreference.saveData(
              key: 'isAdmin',
              value: false,
            ).then((value) {
              isAdmin = false;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          }
          if (state is RegisterFailureState) {
            Fluttertoast.showToast(
              msg: tr('oops_something_went_wrong'),
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
                              tr('sign_up'),
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
                          validate: (value) {
                            if (value.isEmpty) {
                              return tr('name_is_required');
                            }
                            return null;
                          },
                          controller: nameController,
                          prefix: Icons.person,
                          label: tr('full_name'),
                          keyboardType: TextInputType.name,
                          onSaved: (value) {},
                        ),
                        const SizedBox(height: 10),
                        textFormField(
                          controller: emailController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return tr('email_is_required');
                            }
                            return null;
                          },
                          onSaved: (value) {},
                          prefix: Icons.alternate_email_rounded,
                          label: tr('email_address'),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        textFormField(
                          controller: passwordController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return tr('password_cant_be_empty');
                            }
                            return validatePassword(value);
                          },
                          onSaved: (value) {},
                          prefix: Icons.password,
                          suffix: BlocProvider.of<RegisterCubit>(context).suffix,
                          label: tr('password'),
                          obscureText: BlocProvider.of<RegisterCubit>(context).isSecure,
                          suffixFunc: BlocProvider.of<RegisterCubit>(context).changePasswordVisibility,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 10),
                        textFormField(
                          controller: confirmPasswordController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return tr('password_cant_be_empty');
                            }
                            return validatePassword(value);
                          },
                          onSaved: (value) {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<RegisterCubit>(context).register(
                                endPoint: registerEndpoint,
                                data: {
                                  'fullName': nameController.text,
                                  'email': emailController.text,
                                  'password': passwordController.text,
                                  'confirmPassword': confirmPasswordController.text,
                                },
                              );
                            }
                          },
                          prefix: Icons.password,
                          suffix: BlocProvider.of<RegisterCubit>(context).suffix,
                          label: tr('confirm_password'),
                          obscureText: BlocProvider.of<RegisterCubit>(context).isSecure,
                          suffixFunc: BlocProvider.of<RegisterCubit>(context).changePasswordVisibility,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 20),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => customButton(
                            text: tr('sign_up_button'),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(context).register(
                                  endPoint: registerEndpoint,
                                  data: {
                                    'fullName': nameController.text,
                                    'email': emailController.text,
                                    'password': passwordController.text,
                                    'confirmPassword': confirmPasswordController.text,
                                  },
                                );
                              }
                            },
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(color: Colors.green),
                          ),
                        ),
                        Row(
                          children: [
                            Text(tr('already_have_an_account')),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                );
                              },
                              child: Text(
                                tr('login_button'),
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
