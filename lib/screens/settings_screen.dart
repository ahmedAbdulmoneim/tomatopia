import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/profile/profile_cubit.dart';
import 'package:tomatopia/cubit/profile/profile_states.dart';
import 'package:tomatopia/custom_widget/change_name_bottom_sheet.dart';
import 'package:tomatopia/custom_widget/change_password_sheet.dart';
import 'package:tomatopia/custom_widget/toasts.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> bottomSheetFormKey = GlobalKey();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> changImageFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          print(state);
          if (state is ChangeNameSuccessState) {
            BlocProvider.of<ProfileCubit>(context).getUserProfile();
            show(context, 'Done!', 'Name changed successfully', Colors.green);
            nameController.text = '';
            Navigator.pop(context);
          } else if (state is ChangeNameFailureState) {
            show(context, 'Error', "Name not changed", Colors.red);
          } else if (state is ChangePasswordSuccessState) {
            show(context, 'Done!', "Password changed successfully",
                Colors.green);
            oldPasswordController.text = '';
            newPasswordController.text = '';
            confirmPasswordController.text = '';
            Navigator.pop(context);
          } else if (state is ChangePasswordFailuerState) {
            show(context, "Error", 'Password not changed', Colors.red);
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
                                                            Navigator.pop(
                                                                context);
                                                            await profileCubit
                                                                .picImageFromCamera();
                                                            if (profileCubit
                                                                    .imageFile !=
                                                                null) {
                                                              await profileCubit
                                                                  .addUserImage(
                                                                      imageFile:
                                                                          profileCubit
                                                                              .imageFile!);
                                                            } else {
                                                              print(
                                                                  'image is null ');
                                                            }
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .camera_alt_outlined,
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
                                                            Navigator.pop(
                                                                context);
                                                            await profileCubit
                                                                .picImageFromGallery();
                                                            profileCubit.addUserImage(
                                                                imageFile:
                                                                    profileCubit
                                                                        .imageFile!);
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
                                            ),
                                          );
                                        },
                                        icon:
                                            const Icon(Icons.add_a_photo_sharp),
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          profileCubit.newName == null
                                              ? userName
                                              : BlocProvider.of<ProfileCubit>(
                                                      context)
                                                  .newName!,
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
                                        builder: (context) =>
                                            changeNameBottomSheetBuilder(
                                                formKey: formKey,
                                                context: context,
                                                profileCubit: profileCubit,
                                                nameController: nameController),
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
                        const Text(
                          'Notification Settings',
                          style: TextStyle(
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
                            title: const Text('Recived Notification'),
                            onChanged: (value) {
                              print(value);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                            elevation: 4.0,
                            color: Colors.white,
                            margin: const EdgeInsets.fromLTRB(
                                32.0, 8.0, 32.0, 16.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              children: [
                                ListTile(
                                    leading: const Icon(
                                      Icons.lock_outline,
                                      color: Color(0xFF039687),
                                    ),
                                    title: const Text("Change Password"),
                                    trailing:
                                        const Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) =>
                                              changePasswordBottomSheetBuilder(
                                                  bottomSheetFormKey:
                                                      bottomSheetFormKey,
                                                  context: context,
                                                  confirmPasswordController:
                                                      confirmPasswordController,
                                                  oldPasswordController:
                                                      oldPasswordController,
                                                  newPasswordController:
                                                      newPasswordController,
                                                  profileCubit: profileCubit));
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
                                  title: const Text("Change Language"),
                                  trailing:
                                      const Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    //open change password
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
                                  title: const Text("Change Password"),
                                  trailing:
                                      const Icon(Icons.keyboard_arrow_right),
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
