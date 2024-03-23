import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatopia/constant/constant.dart';
import 'package:tomatopia/constant/validate_password.dart';
import 'package:tomatopia/cubit/auth_cubit/change_password/change_password_cubit.dart';
import 'package:tomatopia/cubit/auth_cubit/change_password/change_password_states.dart';
import 'package:tomatopia/custom_widget/custom_button.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';

import '../api_services/tomatopia_services.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> bottomSheetFormKey = GlobalKey();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  File? selectedImage;
  String? name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profile',
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        selectedImage != null
                            ? CircleAvatar(
                                radius: 90,
                                backgroundImage: FileImage(selectedImage!))
                            : const CircleAvatar(
                                radius: 90,
                                backgroundImage:
                                    AssetImage('assets/no_profile_image.png')),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SizedBox(
                                height: 100,
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await takeProfileImage();
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        const Text('camera')
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await loadProfileImage();
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.image,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        const Text('camera')
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add_a_photo_sharp),
                          color: Colors.black,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textFormField(
                      prefix: Icons.person,
                      label: 'change name',
                      onSaved: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      validate: (value) {
                        if (value.toString().isEmpty) {
                          return 'please enter valid name ';
                        }
                      },
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    customButton(
                        text: 'Change name',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                          }
                        },
                        width: double.infinity),
                    const SizedBox(
                      height: 20,
                    ),
                    customButton(
                        text: 'Change password',
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  ChangePasswordCubit(TomatopiaServices(Dio())),
                              child: BlocConsumer<ChangePasswordCubit,
                                  ChangePasswordStates>(
                                listener: (context, state) {
                                  if (state is ChangePasswordSuccessState) {
                                    Fluttertoast.showToast(
                                        msg: 'password changed successfully',
                                        toastLength: Toast.LENGTH_LONG,
                                        backgroundColor: Colors.green,
                                        timeInSecForIosWeb: 5,
                                        textColor: Colors.white,
                                        fontSize: 16.5,
                                        gravity: ToastGravity.CENTER);
                                    oldPasswordController.text = '';
                                    newPasswordController.text = '';
                                    confirmPasswordController.text = '';
                                    Navigator.pop(context);
                                  }
                                  if (state is ChangePasswordFailuerState) {
                                    Fluttertoast.showToast(
                                        msg: 'we cant change password',
                                        toastLength: Toast.LENGTH_LONG,
                                        backgroundColor: Colors.red,
                                        timeInSecForIosWeb: 5,
                                        textColor: Colors.white,
                                        fontSize: 16.5,
                                        gravity: ToastGravity.CENTER);
                                  }
                                },
                                builder: (context, state) {
                                  var cubit =
                                      BlocProvider.of<ChangePasswordCubit>(
                                          context);
                                  return Form(
                                    key: bottomSheetFormKey,
                                    child: Container(
                                      height: 350,
                                      margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom,
                                          top: 20,
                                          left: 10,
                                          right: 10),
                                      child: Column(
                                        children: [
                                          textFormField(
                                            validate: (value) {
                                              if (value.toString().isEmpty) {
                                                return "this filed can't be null";
                                              }
                                              return validatePassword(value);
                                            },
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            obscureText: cubit.isSecure,
                                            prefix: Icons.password,
                                            suffix: cubit.suffixIcon,
                                            suffixFunc: cubit.suffixFunction,
                                            label: 'enter old password',
                                            controller: oldPasswordController,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          textFormField(
                                            validate: (value) {
                                              if (value.toString().isEmpty) {
                                                return "this filed can't be null";
                                              }
                                              return validatePassword(value);
                                            },
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            prefix: Icons.password,
                                            obscureText: cubit.isSecure,
                                            label: 'enter new password',
                                            controller: newPasswordController,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          textFormField(
                                            validate: (value) {
                                              if (value.toString().isEmpty) {
                                                return "this filed can't be null";
                                              }
                                              return validatePassword(value);
                                            },
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            prefix: Icons.password,
                                            obscureText: cubit.isSecure,
                                            suffixFunc: cubit.suffixFunction,
                                            label: 'confirm new password',
                                            controller:
                                                confirmPasswordController,
                                          ),
                                          Row(
                                            children: [
                                              const Spacer(),
                                              TextButton(
                                                  onPressed: () {
                                                    oldPasswordController.text =
                                                        '';
                                                    newPasswordController.text =
                                                        '';
                                                    confirmPasswordController
                                                        .text = '';
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'cancel',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  )),
                                              TextButton(
                                                onPressed: () {
                                                  if (bottomSheetFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    cubit.changePassword(data: {
                                                      "oldPassword":
                                                          oldPasswordController
                                                              .text,
                                                      "newPassword":
                                                          newPasswordController
                                                              .text,
                                                      "confirmPassword":
                                                          confirmPasswordController
                                                              .text,
                                                    });
                                                  }
                                                },
                                                child: const Text(
                                                  'save',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .solid,
                                                      decorationColor:
                                                          Colors.green,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        width: double.infinity)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future takeProfileImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  Future loadProfileImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }
}
