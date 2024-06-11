import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tomatopia/admin/add_admin.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import '../cubit/admin_cubit/admin_states.dart';
import '../custom_widget/toasts.dart';

class Users extends StatelessWidget {
  Users({Key? key}) : super(key: key);
  final TextEditingController pageNumberController = TextEditingController();
  final TextEditingController pageSizeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(context.users),
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddAdmin(),));
          }, child: Text(
            context.addAdmin,
            style: TextStyle(
                color: Colors.green,
                fontSize: 18,
            ),
          ),
          ),
        ],
      ),
      body: BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {
          if (state is DeleteUsersSuccessState) {
            BlocProvider.of<AdminCubit>(context).showAllUsers(
                pageSize: 10,
                pageNumber:
                    BlocProvider.of<AdminCubit>(context).currentPage + 1);
            show(context, context.done, context.userDeletedSuccessfully, Colors.green);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<AdminCubit>(context);
          double number = cubit.numberOfPages / 10;
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
                                              btnCancelText: context.cancel,
                                              btnOkText: context.delete,
                                              btnCancelColor: Colors.green,
                                              btnOkColor: Colors.red,
                                              title:
                                                  '${context.deleteUserConfirmation} : ${cubit.userModel!.users![index].email} .',
                                              animType: AnimType.leftSlide,
                                            ).show();
                                          },
                                          child:  Text(
                                            context.delete,
                                            style: const TextStyle(color: Colors.red),
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
