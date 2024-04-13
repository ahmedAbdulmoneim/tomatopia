import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tomatopia/cubit/admin_cubit/categories_cubit/category_cubit.dart';
import 'package:tomatopia/custom_widget/delete_category.dart';
import 'package:tomatopia/custom_widget/edit_category.dart';
import '../cubit/admin_cubit/categories_cubit/category_states.dart';

class Category extends StatelessWidget {
  Category({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: BlocConsumer<CategoryCubit, CategoryStates>(
        listener: (context, state) {
          if (state is DeleteCategorySuccessState) {
            BlocProvider.of<CategoryCubit>(context).getAllCategories();
            Fluttertoast.showToast(
                msg: 'category deleted successfully',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.green,
                timeInSecForIosWeb: 5,
                textColor: Colors.white,
                fontSize: 16.5,
                gravity: ToastGravity.CENTER);
          }
          if (state is EditeCategorySuccessState) {
            BlocProvider.of<CategoryCubit>(context).getAllCategories();
            Fluttertoast.showToast(
                msg: 'category edited successfully',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.green,
                timeInSecForIosWeb: 5,
                textColor: Colors.white,
                fontSize: 16.5,
                gravity: ToastGravity.CENTER);
          }
          if (state is DeleteCategoryFailureState) {
            Fluttertoast.showToast(
                msg: 'Delete category failed',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 5,
                textColor: Colors.white,
                fontSize: 16.5,
                gravity: ToastGravity.CENTER);
          }
          if (state is EditeCategoryFailureState) {
            Fluttertoast.showToast(
                msg: 'edite category failed',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 5,
                textColor: Colors.white,
                fontSize: 16.5,
                gravity: ToastGravity.CENTER);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<CategoryCubit>(context);
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              CupertinoSearchTextField(
                onSubmitted: (value) {},
              ),
              const SizedBox(
                height: 20,
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
                            '${cubit.categoryList![index]['id']}. ${cubit.categoryList![index]['name']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20, fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        editCategory(context, nameController, formKey, cubit, index),
                        deleteCategory(context, cubit, index, state)
                      ],
                    ),
                    separatorBuilder: (context, index) =>
                        const Divider(height: 30),
                    itemCount: cubit.categoryList!.length,
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
