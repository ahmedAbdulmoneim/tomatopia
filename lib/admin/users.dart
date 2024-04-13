import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/cubit/admin_cubit/users_cubit/users_cubit.dart';
import 'package:tomatopia/custom_widget/custom_button.dart';

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
      body: BlocProvider(
        create: (context) => AdminCubit(TomatopiaServices(Dio())),
        child: BlocBuilder<AdminCubit, AdminStates>(
          builder: (context, state) {
            var cubit = BlocProvider.of<AdminCubit>(context);
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 55,
                              width: 100,
                              child: TextFormField(
                                controller: pageNumberController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "choose page number";
                                  }
                                  return null;
                                },
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                cursorColor: Colors.blueAccent,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.blueAccent))),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Page number',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          DropdownMenu(
                            controller: pageSizeController,
                            inputDecorationTheme: InputDecorationTheme(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent)),
                                contentPadding: const EdgeInsets.only(
                                    top: 2, bottom: 3, right: 5, left: 7),
                                helperStyle: const TextStyle(
                                    color: Colors.black, fontSize: 12)),
                            width: 100,
                            helperText: 'page size',
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(value: 1, label: '1'),
                              DropdownMenuEntry(value: 2, label: '2'),
                              DropdownMenuEntry(value: 3, label: '3'),
                              DropdownMenuEntry(value: 4, label: '4'),
                              DropdownMenuEntry(value: 5, label: '5'),
                              DropdownMenuEntry(value: 6, label: '6'),
                              DropdownMenuEntry(value: 7, label: '7'),
                              DropdownMenuEntry(value: 8, label: '8'),
                              DropdownMenuEntry(value: 9, label: '9'),
                              DropdownMenuEntry(value: 10, label: '10'),
                            ],
                            onSelected: (value) {
                              cubit.changePageSize(value: value);
                            },
                            initialSelection: cubit.pageSize,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  customButton(
                    text: 'Show users',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await cubit.showAllUsers(
                            pageSize: cubit.pageSize,
                            pageNumber: pageNumberController.text);
                      }
                    },
                    width: 200,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: MediaQuery.sizeOf(context).height,
                      child: ListView.separated(
                        itemBuilder: (context, index) => Row(
                          children: [
                            Expanded(
                              child: Text(
                                cubit.userModel![index]['email'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20, fontStyle: FontStyle.italic),
                              ),
                            ),
                            // SizedBox(
                            //   width: MediaQuery.sizeOf(context).width,
                            // ),
                            IconButton(
                              onPressed: () {
                                AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.warning,
                                        btnOkOnPress: () async {
                                          await cubit.deleteUser(
                                              email: cubit.userModel![index]
                                                  ['email']);
                                          if (state
                                                  is GetAllUsersSuccessState ||
                                              state
                                                  is DeleteUsersSuccessState) {
                                            cubit.showAllUsers(
                                                pageSize: cubit.pageSize,
                                                pageNumber:
                                                    pageNumberController.text);
                                          }
                                        },
                                        btnCancelOnPress: () {},
                                        btnCancelText: 'Cancel',
                                        btnOkText: 'Delete',
                                        btnCancelColor: Colors.green,
                                        btnOkColor: Colors.red,
                                        title: 'Are You Sure You Want To Delete This User .',
                                        animType: AnimType.leftSlide,
                                ).show();
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                        separatorBuilder: (context, index) =>
                            const Divider(height: 30),
                        itemCount: cubit.userModel?.length == null
                            ? 0
                            : cubit.userModel!.length,
                      ),
                    ),
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
