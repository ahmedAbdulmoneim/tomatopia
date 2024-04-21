import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../cubit/admin_cubit/categories_cubit/category_states.dart';

Widget deleteCategory({context, cubit, index, state}) => IconButton(
  onPressed: () {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      btnOkOnPress: ()  async{
        await cubit.deleteCategory(id: cubit.categoryList![index]['id']);
        if(state is GetAllCategorySuccessState || state is DeleteCategorySuccessState){
          cubit.getAllCategories();
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
);