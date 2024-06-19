import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/admin/all_reviews.dart';
import 'package:tomatopia/admin/category.dart';
import 'package:tomatopia/admin/disease/diseases.dart';
import 'package:tomatopia/admin/tips/tips.dart';
import 'package:tomatopia/admin/treatments/treatments.dart';
import 'package:tomatopia/admin/users.dart';

import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/custom_widget/extensions.dart';

import '../cubit/admin_cubit/admin_states.dart';


Widget containerPanel(String title) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.green[100],
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(context.adminPanel),
      ),
      body: BlocBuilder<AdminCubit,AdminStates>(
        builder: (context, state) {
          int pageNumber = BlocProvider.of<AdminCubit>(context).currentPage;
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView(
              children: [
                const Icon(
                  Icons.admin_panel_settings_sharp,
                  color: Colors.green,
                  size: 80,
                ),
                const SizedBox(height: 30),
                 GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Users()),
                        );
                        await BlocProvider.of<AdminCubit>(context).showAllUsers(
                          pageSize: 10,
                          pageNumber: pageNumber + 1,
                        );
                      },
                      child: containerPanel(context.users),
                    ),
                const SizedBox(height: 15),
                GestureDetector(
                      onTap: () {
                        BlocProvider.of<AdminCubit>(context).getAllCategories();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Category()),
                        );
                      },
                      child: containerPanel(context.categories),
                    ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () async{
                    BlocProvider.of<AdminCubit>(context).getAllTips();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Tips()),
                    );
                  },
                  child: containerPanel(context.tips),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AllDiseases()),
                        );
                         await BlocProvider.of<AdminCubit>(context).getAllDisease();
                         BlocProvider.of<AdminCubit>(context).getAllTreatment();
                      },
                      child: containerPanel(context.diseases),
                    ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Treatments()),
                    );
                    BlocProvider.of<AdminCubit>(context).getAllTreatment();
                  },
                  child: containerPanel(context.treatments),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  ShowAllReviews()),
                    );
                    BlocProvider.of<AdminCubit>(context).getAllReviews();
                  },
                  child: containerPanel(context.reviews),
                ),

              ],
            ),
          );
        },

      ),
    );
  }
}


