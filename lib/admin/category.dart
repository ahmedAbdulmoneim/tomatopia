import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/cubit/admin_cubit/categories_cubit/category_cubit.dart';
import 'package:tomatopia/custom_widget/add_category.dart';
import 'package:tomatopia/custom_widget/category_list_item.dart';
import '../cubit/admin_cubit/categories_cubit/category_states.dart';

class Category extends StatelessWidget {
  Category({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController newCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryStates>(
      listener: (context, state) {
        if (state is AddCategorySuccessState) {
          BlocProvider.of<CategoryCubit>(context).getAllCategories();
        }
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
        if (state is AddCategorySuccessState) {
          BlocProvider.of<CategoryCubit>(context).getAllCategories();
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
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Category',
              ),
            ),
            body: state is GetAllCategoryLoadingState || state is GetAllCategoryFailureState
                ? Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.green, size: 50))
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(children: [
                      addCategory(context, formKey, newCategory, cubit),
                      const SizedBox(
                        height: 15,
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
                            itemBuilder: (context, index) => categoryListItem(context, nameController, cubit, index, formKey, state),
                            separatorBuilder: (context, index) =>
                                const Divider(height: 30),
                            itemCount: cubit.categoryList!.length,
                          ),
                        ),
                      ),
                    ]),
                  ));
      },
    );
  }
}
