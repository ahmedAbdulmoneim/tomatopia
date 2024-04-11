import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tomatopia/admin/category.dart';
import 'package:tomatopia/admin/disease.dart';
import 'package:tomatopia/admin/tips.dart';
import 'package:tomatopia/admin/users.dart';
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
            containerPanel(context, Users(), 'users'),
            const SizedBox(
              height: 15,
            ),
            containerPanel(context, Category(), 'categories'),
            const SizedBox(
              height: 15,
            ),
            containerPanel(context, Tips(), 'tips'),
            const SizedBox(
              height: 15,
            ),
            containerPanel(context, Disease(), 'disease'),
          ],
        ),
      ),
    );
  }
}
