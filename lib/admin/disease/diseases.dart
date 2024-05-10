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
              itemBuilder: (context, index) => Card(
                elevation: 6,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.only(
                    left: 15, right: 15, top: 8, bottom: 8),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            base64Decode(cubit.allDisease[index].image!),
                            fit: BoxFit.fill,
                            width: 70,
                            height: 70,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.allDisease[index].name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                cubit.allDisease[index].category!.name!,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                         IconButton(
                            onPressed: (){
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                btnOkOnPress: () async {
                                  await cubit.deleteDiseases(
                                      id: cubit.allDisease[index].id!
                                  );
                                  if (state
                                  is GetAllDiseaseSuccessState ||
                                      state
                                      is DeleteDiseaseSuccessState) {
                                    cubit.getAllDisease();
                                  }
                                },
                                btnCancelOnPress: () {},
                                btnCancelText: 'Cancel',
                                btnOkText: 'Delete',
                                btnCancelColor: Colors.green,
                                btnOkColor: Colors.red,
                                title:
                                'Are you sure you want to delete this disease ${cubit.allDisease[index].name} .',
                                animType: AnimType.leftSlide,
                              ).show();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),),
                      ],
                    ),
                  ),
                ),
              ),
              itemCount: cubit.allDisease.length,
            ),
          ),
        );
      },
    );
  }
}



