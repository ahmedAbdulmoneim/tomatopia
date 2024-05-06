import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tomatopia/cubit/admin_cubit/users_cubit/users_cubit.dart';
import '../cubit/admin_cubit/users_cubit/users_states.dart';

class Users extends StatelessWidget {
  Users({Key? key}) : super(key: key);
  final TextEditingController pageNumberController = TextEditingController();
  final TextEditingController pageSizeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {
          if (state is DeleteUsersSuccessState) {
            BlocProvider.of<AdminCubit>(context).showAllUsers(
                pageSize: 10,
                pageNumber:
                    BlocProvider.of<AdminCubit>(context).currentPage + 1);
            Fluttertoast.showToast(
              msg: 'user deleted successfully',
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.green,
              timeInSecForIosWeb: 5,
              textColor: Colors.white,
              fontSize: 16.5,
              gravity: ToastGravity.SNACKBAR, // Center gravity
            );
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<AdminCubit>(context);
          double number = cubit.userModel!.usersNumber! / 10;
          int numberOfPages = number.ceil();
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: state is GetAllUsersLoadingState ||
                              state is GetAllUsersFailuerState
                          ? Center(
                              child: LoadingAnimationWidget.fourRotatingDots(
                                  color: Colors.green, size: 50))
                          : ListView.separated(
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${cubit.userModel!.users![index].email}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.warning,
                                              btnOkOnPress: () async {
                                                await cubit.deleteUser(
                                                    email: cubit.userModel!
                                                        .users![index].email!);
                                                if (state
                                                        is GetAllUsersSuccessState ||
                                                    state
                                                        is DeleteUsersSuccessState) {
                                                  cubit.showAllUsers(
                                                      pageSize: 10,
                                                      pageNumber:
                                                          cubit.currentPage +
                                                              1);
                                                }
                                              },
                                              btnCancelOnPress: () {},
                                              btnCancelText: 'Cancel',
                                              btnOkText: 'Delete',
                                              btnCancelColor: Colors.green,
                                              btnOkColor: Colors.red,
                                              title:
                                                  'Are you sure you want to delete this user ${cubit.userModel!.users![index].email} .',
                                              animType: AnimType.leftSlide,
                                            ).show();
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ))
                                    ],
                                  ),
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    height: 20,
                                  ),
                              itemCount: cubit.userModel!.users!.length <= 10
                                  ? cubit.userModel!.users!.length
                                  : 10),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Change the color here
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // Add shadow color here
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: NumberPaginator(
                    numberPages: numberOfPages,
                    initialPage: min(cubit.currentPage, numberOfPages - 1),
                    onPageChange: (index) {
                      cubit.onPageChange(index);
                      cubit.showAllUsers(pageSize: 10, pageNumber: index + 1);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
