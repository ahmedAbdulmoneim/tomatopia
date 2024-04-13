import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/admin/category.dart';
import 'package:tomatopia/admin/disease.dart';
import 'package:tomatopia/admin/tips.dart';
import 'package:tomatopia/admin/users.dart';
import 'package:tomatopia/cubit/admin_cubit/categories_cubit/category_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/categories_cubit/category_states.dart';
import 'package:tomatopia/custom_widget/admin_panel_container.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25),
        child: ListView(
          children: [
            Image.asset('assets/admin.png'),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Users(),
                      ));
                },
                child: containerPanel('users')),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<CategoryCubit, CategoryStates>(
              builder: (context, state) {
                return GestureDetector(
                    onTap: () {
                      BlocProvider.of<CategoryCubit>(context)
                          .getAllCategories();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Category(),));
                    },
                    child: containerPanel('categories'));
              },
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Tips(),
                      ));
                },
                child: containerPanel('tips')),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Disease(),
                      ));
                },
                child: containerPanel('disease')),
          ],
        ),
      ),
    );
  }
}
