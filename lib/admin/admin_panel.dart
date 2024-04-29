import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/admin/category.dart';
import 'package:tomatopia/admin/disease/add_disease.dart';
import 'package:tomatopia/admin/disease/diseases.dart';
import 'package:tomatopia/admin/tips.dart';
import 'package:tomatopia/admin/users.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/cubit/admin_cubit/categories_cubit/category_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/categories_cubit/category_states.dart';
import 'package:tomatopia/cubit/admin_cubit/disease/disease_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/disease/disease_states.dart';
import 'package:tomatopia/cubit/admin_cubit/users_cubit/users_cubit.dart';
import 'package:tomatopia/custom_widget/admin_panel_container.dart';

import '../cubit/admin_cubit/users_cubit/users_states.dart';

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
            Image.asset('assets/admin.png',height: 170,),
            BlocBuilder<AdminCubit,AdminStates>(
              builder: (context, state) {
                return  GestureDetector(
                    onTap: () async{
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Users(),
                          ));
                      await BlocProvider.of<AdminCubit>(context).showAllUsers(pageSize: 10, pageNumber: 1);

                    },
                    child: containerPanel('users'));
              },
            ),
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
            BlocBuilder<DiseaseCubit,DiseaseStates>(
              builder: (context, state) {
                return GestureDetector(
                    onTap: () async{
                      if(BlocProvider.of<DiseaseCubit>(context).allDisease.isNotEmpty){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllDiseases(),
                            ));
                      }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllDiseases(),
                            ));
                        await BlocProvider.of<DiseaseCubit>(context).getAllDisease();

                      }

                    },
                    child: containerPanel('disease'));
              }
            ),
          ],
        ),
      ),
    );
  }
}
