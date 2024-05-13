import 'dart:convert';
import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/admin/disease/add_disease.dart';
import 'package:tomatopia/custom_widget/toasts.dart';
import 'package:tomatopia/page_transitions/scale_transition.dart';
import 'package:tomatopia/screens/about_disease.dart';
import 'package:tomatopia/cubit/admin_cubit/disease/disease_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/disease/disease_states.dart';

import '../../custom_widget/custom_card.dart';

class AllDiseases extends StatelessWidget {
  const AllDiseases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiseaseCubit, DiseaseStates>(
      listener: (context, state) {
        if(state is DeleteDiseaseSuccessState){
          show(context, 'Done', 'Disease deleted successfully!', Colors.green);
          BlocProvider.of<DiseaseCubit>(context).getAllDisease();
        }
        if(state is DeleteDiseaseFailureState){
          show(context, 'Error', 'Failed to delete disease', Colors.red);
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<DiseaseCubit>(context);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: const Text('All Diseases'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                  SizeTransition1(AddDisease()));
                },
                icon: Container(
                  padding: const EdgeInsets.all(5),
                    decoration:  BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add)),
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: state is GetAllDiseaseLoadingState || state is GetAllDiseaseFailureState,
            builder: (context) => Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blue, size: 50)),
            fallback: (context) => ListView.builder(
              itemBuilder: (context, index) => card(
                  image: cubit.allDisease[index].image!,
                  index: index,
                  context: context,
                  dialogTitle: 'Are you sure you want to delete this disease:  ${cubit.allDisease[index].name} .',
                  mainTitle: cubit.allDisease[index].name!,
                  subtitle: cubit.allDisease[index].category!.name!,
                  onPressed: () async {
                    await cubit.deleteDiseases(
                        id: cubit.allDisease[index].id!
                    );
                    if (state
                    is GetAllDiseaseSuccessState ||
                        state
                        is DeleteDiseaseSuccessState) {
                      cubit.getAllDisease();
                    }
                  }),
              itemCount: cubit.allDisease.length,
            ),
          ),
        );
      },
    );
  }
}



