import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_states.dart';
import 'package:tomatopia/custom_widget/add_category.dart';
import 'package:tomatopia/custom_widget/category_list_item.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import '../custom_widget/toasts.dart';

class Category extends StatelessWidget {
  Category({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController newCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is AddCategorySuccessState) {
          BlocProvider.of<AdminCubit>(context).getAllCategories();
          show(context, context.done, context.categoryAddedSuccessfully, Colors.green);
        }
        if (state is DeleteCategorySuccessState) {
          BlocProvider.of<AdminCubit>(context).getAllCategories();
          show(context, context.done, context.categoryDeletedSuccessfully, Colors.green);
        }
        if (state is EditeCategorySuccessState) {
          BlocProvider.of<AdminCubit>(context).getAllCategories();
          show(context, context.done, context.categoryUpdatedSuccessfully, Colors.green);
        }
        if (state is DeleteCategoryFailureState) {
          show(context, context.error, context.deleteFailed, Colors.red);
        }
        if (state is EditeCategoryFailureState) {
          show(context, context.error, context.editCategoryFailed, Colors.red);
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<AdminCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(context.category),
          ),
          body: state is GetAllCategoryLoadingState || state is GetAllCategoryFailureState
              ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.green, size: 50))
              : Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              addCategory(context, formKey, newCategory, cubit),
              const SizedBox(height: 15),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.sizeOf(context).height,
                  child: ListView.separated(
                    itemBuilder: (context, index) => categoryListItem(
                        context, nameController, cubit, index, formKey, state),
                    separatorBuilder: (context, index) =>
                    const Divider(height: 30),
                    itemCount: cubit.categoryList.length,
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
