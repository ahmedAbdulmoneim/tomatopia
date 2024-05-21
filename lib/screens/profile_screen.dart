import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/constant/validate_password.dart';

import 'package:tomatopia/cubit/profile/profile_cubit.dart';
import 'package:tomatopia/cubit/profile/profile_states.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';

import '../api_services/tomatopia_services.dart';

class Profile extends StatelessWidget {
  Profile({super.key,required this.image});
  String image ;
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
            if(state is AddProfileImageSuccessState){
              print('profile : ${BlocProvider.of<ProfileCubit>(context).profileModel?.image}');
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
                            BlocProvider.of<ProfileCubit>(context).profileModel?.image == null
                                ?
                            const CircleAvatar(
                                radius: 90,
                                backgroundImage:
                                AssetImage('assets/no_profile_image.png'))
                                :
                            CircleAvatar(
                              radius: 90,
                              backgroundImage: NetworkImage('http://graduationprojec.runasp.net//${BlocProvider.of<ProfileCubit>(context).profileModel!.image}')),
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
                                      BlocProvider.of<ProfileCubit>(context).getUserProfile();
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

