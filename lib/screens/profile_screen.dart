import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/constant/validate_password.dart';
import 'package:tomatopia/cubit/auth_cubit/change_password/change_password_cubit.dart';
import 'package:tomatopia/cubit/auth_cubit/change_password/change_password_states.dart';
import 'package:tomatopia/cubit/profile/profile_cubit.dart';
import 'package:tomatopia/cubit/profile/profile_states.dart';
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
  TextEditingController nameController = TextEditingController();
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
          ),
          centerTitle: true,
        ),
        body: BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(TomatopiaServices(Dio()))..userData(),
          child: BlocConsumer<ProfileCubit, ProfileStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var profile = BlocProvider.of<ProfileCubit>(context);
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              selectedImage != null
                                  ? CircleAvatar(
                                      radius: 90,
                                      backgroundImage:
                                          FileImage(selectedImage!))
                                  : const CircleAvatar(
                                      radius: 90,
                                      backgroundImage: AssetImage(
                                          'assets/no_profile_image.png')),
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
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                profile.profileModel?.name == null
                                    ? userName
                                    : profile.profileModel!.name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) =>
                                      BlocConsumer<ProfileCubit, ProfileStates>(
                                    listener: (context, state) {
                                      if (state is ProfileSuccessState) {
                                        Fluttertoast.showToast(
                                            msg: 'name changed successfully',
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor: Colors.green,
                                            timeInSecForIosWeb: 5,
                                            textColor: Colors.white,
                                            fontSize: 16.5,
                                            gravity: ToastGravity.CENTER);
                                        nameController.text = '';
                                        Navigator.pop(context);
                                      }
                                      if (state is ChangePasswordFailuerState) {
                                        Fluttertoast.showToast(
                                            msg: "name doesn't changed",
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor: Colors.red,
                                            timeInSecForIosWeb: 5,
                                            textColor: Colors.white,
                                            fontSize: 16.5,
                                            gravity: ToastGravity.CENTER);
                                      }
                                    },
                                    builder: (context, state) {
                                      var cubit = BlocProvider.of<ProfileCubit>(
                                          context);
                                      return Form(
                                        key: formKey,
                                        child: Container(
                                          height: 200,
                                          margin: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom,
                                              top: 20,
                                              left: 10,
                                              right: 10),
                                          child: Column(
                                            children: [
                                              textFormField(
                                                validate: (value) {
                                                  if (value
                                                      .toString()
                                                      .isEmpty) {
                                                    return "this filed can't be null";
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.name,
                                                prefix: Icons.person,
                                                label: 'enter new name ',
                                                controller: nameController,
                                              ),
                                              Row(
                                                children: [
                                                  const Spacer(),
                                                  TextButton(
                                                      onPressed: () {
                                                        nameController.text =
                                                            '';
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
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        print('object');
                                                      }
                                                    },
                                                    child: const Text(
                                                      'save',
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationStyle:
                                                              TextDecorationStyle
                                                                  .solid,
                                                          decorationColor:
                                                              Colors.green,
                                                          textBaseline:
                                                              TextBaseline
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
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.email,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              profile.profileModel?.email == null
                                  ? userEmail
                                  : profile.profileModel!.email,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.lock,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'change password',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => BlocProvider(
                                    create: (context) => ChangePasswordCubit(
                                        TomatopiaServices(Dio())),
                                    child: BlocConsumer<ChangePasswordCubit,
                                        ChangePasswordStates>(
                                      listener: (context, state) {
                                        if (state
                                            is ChangePasswordSuccessState) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'password changed successfully',
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
                                        if (state
                                            is ChangePasswordFailuerState) {
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
                                        var cubit = BlocProvider.of<
                                            ChangePasswordCubit>(context);
                                        return Form(
                                          key: bottomSheetFormKey,
                                          child: Container(
                                            height: 350,
                                            margin: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                                top: 20,
                                                left: 10,
                                                right: 10),
                                            child: Column(
                                              children: [
                                                textFormField(
                                                  validate: (value) {
                                                    if (value
                                                        .toString()
                                                        .isEmpty) {
                                                      return "this filed can't be null";
                                                    }
                                                    return validatePassword(
                                                        value);
                                                  },
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  obscureText: cubit.isSecure,
                                                  prefix: Icons.password,
                                                  suffix: cubit.suffixIcon,
                                                  suffixFunc:
                                                      cubit.suffixFunction,
                                                  label: 'enter old password',
                                                  controller:
                                                      oldPasswordController,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                textFormField(
                                                  validate: (value) {
                                                    if (value
                                                        .toString()
                                                        .isEmpty) {
                                                      return "this filed can't be null";
                                                    }
                                                    return validatePassword(
                                                        value);
                                                  },
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  prefix: Icons.password,
                                                  obscureText: cubit.isSecure,
                                                  label: 'enter new password',
                                                  controller:
                                                      newPasswordController,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                textFormField(
                                                  validate: (value) {
                                                    if (value
                                                        .toString()
                                                        .isEmpty) {
                                                      return "this filed can't be null";
                                                    }
                                                    return validatePassword(
                                                        value);
                                                  },
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  prefix: Icons.password,
                                                  obscureText: cubit.isSecure,
                                                  suffixFunc:
                                                      cubit.suffixFunction,
                                                  label: 'confirm new password',
                                                  controller:
                                                      confirmPasswordController,
                                                ),
                                                Row(
                                                  children: [
                                                    const Spacer(),
                                                    TextButton(
                                                        onPressed: () {
                                                          oldPasswordController
                                                              .text = '';
                                                          newPasswordController
                                                              .text = '';
                                                          confirmPasswordController
                                                              .text = '';
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'cancel',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        )),
                                                    TextButton(
                                                      onPressed: () {
                                                        if (bottomSheetFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          cubit.changePassword(
                                                              data: {
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
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationStyle:
                                                                TextDecorationStyle
                                                                    .solid,
                                                            decorationColor:
                                                                Colors.green,
                                                            textBaseline:
                                                                TextBaseline
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
                              icon: const Icon(
                                Icons.edit,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
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
