import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';

import 'delete_category.dart';
import 'edit_category.dart';

Widget categoryListItem(context,nameController,cubit,index,formKey,state) => Row(
  children: [
    Expanded(
      child: Text(
         BlocProvider.of<AdminCubit>(context).categoryList[index].name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
    editCategory(context: context,name:  nameController,key:  formKey,cubit: cubit,index: index),
    deleteCategory(context: context,cubit: cubit,index:  index, state: state)
  ],
);