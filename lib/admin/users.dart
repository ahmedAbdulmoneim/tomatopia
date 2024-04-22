import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tomatopia/cubit/admin_cubit/users_cubit/users_cubit.dart';
import 'package:tomatopia/custom_widget/delete_category.dart';
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
      body: BlocBuilder<AdminCubit, AdminStates>(
        builder: (context, state) {
          var cubit = BlocProvider.of<AdminCubit>(context);
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
                                  '${cubit.userModel![index]['email']}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              deleteCategory(
                                  cubit: cubit,
                                  index: index,
                                  state: state,
                                  context: context)
                            ],
                          ),
                          separatorBuilder: (context, index) =>
                          const Divider(
                            height: 20,
                          ),
                          itemCount: cubit.userModel!.length <= 10
                              ? cubit.userModel!.length
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
                        color: Colors.grey.withOpacity(0.5), // Add shadow color here
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: NumberPaginator(
                    numberPages: 4,
                    initialPage: cubit.currentPage,
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

