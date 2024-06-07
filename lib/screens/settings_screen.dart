import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:get/get.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/profile/profile_cubit.dart';
import 'package:tomatopia/cubit/profile/profile_states.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'package:tomatopia/custom_widget/toasts.dart';
import 'package:tomatopia/shared_preferences/shared_preferences.dart';

import '../constant/validate_password.dart';
import '../custom_widget/text_form_filed.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> bottomSheetFormKey = GlobalKey();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormState> changImageFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(context.settings),
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileSuccessState) {
            SharedPreference.saveData(key: 'userImage', value: BlocProvider.of<ProfileCubit>(context).profileModel!.image!).then((value) {
              userImage = BlocProvider.of<ProfileCubit>(context).profileModel!.image!;
            });
            SharedPreference.saveData(key: 'userName', value: BlocProvider.of<ProfileCubit>(context).profileModel!.name).then((value) {
              userName = BlocProvider.of<ProfileCubit>(context).profileModel!.name;
            });
          }
          if (state is ChangeNameSuccessState) {
            BlocProvider.of<ProfileCubit>(context).getUserProfile();
            show(context, context.done, context.nameChangedSuccessfully, Colors.green);
            nameController.text = '';
            Navigator.pop(context);
          } else if (state is ChangeNameFailureState) {
            show(context, context.error, context.nameNotChanged, Colors.red);
          } else if (state is ChangePasswordSuccessState) {
            show(context, context.done, context.passwordChangedSuccessfully, Colors.green);
            oldPasswordController.text = '';
            newPasswordController.text = '';
            confirmPasswordController.text = '';
            Navigator.pop(context);
          } else if (state is ChangePasswordFailuerState) {
            show(context, context.error, context.passwordNotChanged, Colors.red);
          } else if (state is AddProfileImageSuccessState) {
            BlocProvider.of<ProfileCubit>(context).getUserProfile();
          }
        },
        builder: (context, state) {
          var profileCubit = BlocProvider.of<ProfileCubit>(context);
          return Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: const Color(0xFF039687),
                          child: SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                          radius: 60,
                                          backgroundImage: profileCubit
                                              .profileModel?.image !=
                                              null
                                              ? NetworkImage(
                                              '$basUrlImage${profileCubit.profileModel!.image}')
                                              : NetworkImage(noImage)),
                                      IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Form(
                                              key: changImageFormKey,
                                              child: SizedBox(
                                                height: 100,
                                                child: Row(
                                                  children: [
                                                    const Spacer(),
                                                    Column(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () async {
                                                            Navigator.pop(context);
                                                            await profileCubit.picImageFromCamera();
                                                            if (profileCubit.imageFile != null) {
                                                              await profileCubit.addUserImage(
                                                                  imageFile: profileCubit.imageFile!);
                                                            } else {
                                                            }
                                                          },
                                                          icon: const Icon(
                                                            Icons.camera_alt_outlined,
                                                            color: Colors.blue,
                                                          ),
                                                        ),
                                                        Text(context.camera)
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Column(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () async {
                                                            Navigator.pop(context);
                                                            await profileCubit.picImageFromGallery();
                                                            profileCubit.addUserImage(
                                                                imageFile: profileCubit.imageFile!);
                                                          },
                                                          icon: const Icon(
                                                            Icons.image,
                                                            color: Colors.blue,
                                                          ),
                                                        ),
                                                        Text(context.gallery)
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                  ],
                                                ),
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
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          profileCubit.newName == null
                                              ? userName
                                              : BlocProvider.of<ProfileCubit>(context).newName!,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) =>Form(
                                          key: formKey,
                                          child: Container(
                                            height: 200,
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
                                                      return context.thisFieldCannotBeNull;
                                                    }
                                                  },
                                                  keyboardType: TextInputType.name,
                                                  prefix: Icons.person,
                                                  label: context.enterNewName,
                                                  controller: nameController,
                                                ),
                                                Row(
                                                  children: [
                                                    const Spacer(),
                                                    TextButton(
                                                        onPressed: () {
                                                          nameController.text = '';
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text(
                                                          context.cancel,
                                                          style: const TextStyle(
                                                            color: Colors.black54,
                                                          ),
                                                        )),
                                                    TextButton(
                                                      onPressed: () {
                                                        if (formKey.currentState!.validate()) {
                                                          profileCubit.changeUserName(newName: nameController.text);
                                                        }
                                                      },
                                                      child: Text(
                                                        context.save,
                                                        style: const TextStyle(
                                                          color: Colors.green,
                                                          decoration: TextDecoration.underline,
                                                          decorationStyle: TextDecorationStyle.solid,
                                                          decorationColor: Colors.green,
                                                          textBaseline: TextBaseline.alphabetic,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          context.notificationSettings,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF87c8c1),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SwitchListTile(
                            value: true,
                            activeColor: const Color(0xFF039687),
                            title: Text(context.receivedNotification),
                            onChanged: (value) {
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                            elevation: 4.0,
                            color: Colors.white,
                            margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              children: [
                                ListTile(
                                    leading: const Icon(
                                      Icons.lock_outline,
                                      color: Color(0xFF039687),
                                    ),
                                    title: Text(context.changePassword),
                                    trailing: const Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (x) =>Form(
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
                                                        return context.thisFieldCannotBeNull;
                                                      }
                                                      return validatePassword(value);
                                                    },
                                                    keyboardType: TextInputType.visiblePassword,
                                                    obscureText: profileCubit.isSecure,
                                                    prefix: Icons.password,
                                                    suffix: profileCubit.suffixIcon,
                                                    suffixFunc: profileCubit.suffixFunction,
                                                    label: context.enterOldPassword,
                                                    controller: oldPasswordController,
                                                  ),
                                                  const SizedBox(height: 15),
                                                  textFormField(
                                                    validate: (value) {
                                                      if (value.toString().isEmpty) {
                                                        return context.thisFieldCannotBeNull;
                                                      }
                                                      return validatePassword(value);
                                                    },
                                                    keyboardType: TextInputType.visiblePassword,
                                                    prefix: Icons.password,
                                                    obscureText: profileCubit.isSecure,
                                                    label: context.enterNewPassword,
                                                    controller: newPasswordController,
                                                  ),
                                                  const SizedBox(height: 15),
                                                  textFormField(
                                                    validate: (value) {
                                                      if (value.toString().isEmpty) {
                                                        return context.thisFieldCannotBeNull;
                                                      }
                                                      return validatePassword(value);
                                                    },
                                                    keyboardType: TextInputType.visiblePassword,
                                                    prefix: Icons.password,
                                                    obscureText: profileCubit.isSecure,
                                                    suffixFunc: profileCubit.suffixFunction,
                                                    label: context.confirmNewPassword,
                                                    controller: confirmPasswordController,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Spacer(),
                                                      TextButton(
                                                          onPressed: () {
                                                            oldPasswordController.text = '';
                                                            newPasswordController.text = '';
                                                            confirmPasswordController.text = '';
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            context.cancel,
                                                            style: const TextStyle(
                                                              color: Colors.black54,
                                                            ),
                                                          )),
                                                      TextButton(
                                                        onPressed: () {
                                                          if (bottomSheetFormKey.currentState!.validate()) {
                                                            profileCubit.changePassword(data: {
                                                              "oldPassword": oldPasswordController.text,
                                                              "newPassword": newPasswordController.text,
                                                              "confirmPassword": confirmPasswordController.text,
                                                            });
                                                          }
                                                        },
                                                        child: Text(
                                                          context.save,
                                                          style: const TextStyle(
                                                            color: Colors.green,
                                                            decoration: TextDecoration.underline,
                                                            decorationStyle: TextDecorationStyle.solid,
                                                            decorationColor: Colors.green,
                                                            textBaseline: TextBaseline.alphabetic,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                    }),
                                const Divider(
                                  endIndent: 8,
                                  indent: 8,
                                ),
                                ListTile(
                                  leading: const Icon(
                                    FontAwesomeIcons.earthAfrica,
                                    color: Color(0xFF039687),
                                  ),
                                  title: Text(context.changeLanguage),
                                  trailing: const Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => SizedBox(
                                        height: 150,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: const Text('English'),
                                              onTap: () async{
                                                Navigator.pop(context);
                                                await context.setLocale(const Locale('en'));
                                                Get.updateLocale(const Locale('en'));

                                              },
                                            ),
                                            ListTile(
                                              title: const Text('العربية'),
                                              onTap: () async{
                                                Navigator.pop(context);
                                                 await context.setLocale(const Locale('ar'));
                                                 Get.updateLocale(const Locale('ar'));

                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const Divider(
                                  endIndent: 8,
                                  indent: 8,
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.location_on,
                                    color: Color(0xFF039687),
                                  ),
                                  title: Text(context.changeLocation),
                                  trailing: const Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    //open change password
                                  },
                                ),
                              ],
                            )),
                      ]),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

