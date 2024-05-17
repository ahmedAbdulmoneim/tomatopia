import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/constant/validate_password.dart';
import 'package:tomatopia/cubit/auth_cubit/change_password/change_password_cubit.dart';
import 'package:tomatopia/cubit/auth_cubit/change_password/change_password_states.dart';
import 'package:tomatopia/cubit/profile/profile_cubit.dart';
import 'package:tomatopia/cubit/profile/profile_states.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';

import '../api_services/tomatopia_services.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> bottomSheetFormKey = GlobalKey();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
        body: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            if(state is ChangeNameSuccessState){
              BlocProvider.of<ProfileCubit>(context).profileModel!.name = nameController.text;
            }

          },
          builder: (context, state) {
            var profileCubit = BlocProvider.of<ProfileCubit>(context);
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
                            userImage == ""
                                ?
                            const CircleAvatar(
                                radius: 90,
                                backgroundImage:
                                AssetImage('assets/no_profile_image.png'))
                                :
                            CircleAvatar(
                              radius: 90,
                              backgroundImage: NetworkImage('http://graduationprojec.runasp.net//$userImage')),
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
                                                Navigator.pop(context);                                                await profileCubit.picImageFromCamera();
                                                profileCubit.addUserImage(data: profileCubit.formData!);

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
                                                Navigator.pop(context);
                                                await profileCubit.picImageFromGallery();
                                                profileCubit.addUserImage(data: profileCubit.formData!);

                                              },
                                              icon: const Icon(
                                                Icons.image,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            const Text('gallery')
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
                              BlocProvider.of<ProfileCubit>(context).newName == null ? userName : BlocProvider.of<ProfileCubit>(context).newName!,
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
                                builder: (context) => BlocConsumer<ProfileCubit,
                                    ProfileStates>(
                                  listener: (context, state) {
                                    if (state is ChangeNameSuccessState) {
                                      BlocProvider.of<ProfileCubit>(context).userData();
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
                                    if (state
                                    is ChangePasswordFailuerState) {
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
                                    var cubit =
                                    BlocProvider.of<ProfileCubit>(
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
                                              keyboardType: TextInputType.name,
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
                                                    if (formKey.currentState!.validate()){
                                                      cubit.changeUserName(newName: nameController.text);

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
                          Expanded(
                            child: Text(
                              profileCubit.profileModel?.email == null
                                  ? userEmail
                                  : profileCubit.profileModel!.email,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
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
    );
  }
}

