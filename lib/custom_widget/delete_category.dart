import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../cubit/admin_cubit/admin_states.dart';


Widget deleteCategory({context, cubit, index, state}) => IconButton(
  onPressed: () {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      btnOkOnPress: ()  async{
        await cubit.deleteCategory(id: cubit.categoryList![index].id);
        if(state is GetAllCategorySuccessState || state is DeleteCategorySuccessState){
          cubit.getAllCategories();
        }
      },
      btnCancelOnPress: () {},
      btnCancelText: 'cancel'.tr(),
      btnOkText: 'delete'.tr(),
      btnCancelColor: Colors.green,
      btnOkColor: Colors.red,
      title: 'delete_category_confirmation'.tr(),
      animType: AnimType.leftSlide,
    ).show();

  },
  icon: const Icon(
    Icons.delete,
    color: Colors.red,
  ),
);