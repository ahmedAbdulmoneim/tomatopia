import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/admin/disease/add_disease.dart';
import 'package:tomatopia/admin/disease/edit_disease.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_states.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'package:tomatopia/custom_widget/toasts.dart';
import 'package:tomatopia/page_transitions/scale_transition.dart';


import '../../custom_widget/custom_card_admin.dart';

class AllDiseases extends StatelessWidget {
  const AllDiseases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if(state is DeleteDiseaseSuccessState){
          show(context, context.done, context.diseaseDeletedSuccessfully, Colors.green);
          BlocProvider.of<AdminCubit>(context).getAllDisease();
        }
        if(state is DeleteDiseaseFailureState){
          show(context, context.error, context.failedToDeleteDisease, Colors.red);
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<AdminCubit>(context);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title:  Text(context.allDiseases),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                  SizeTransition1(const AddDisease()));
                  cubit.getAllCategories();
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
              itemBuilder: (context, index) => customCardAdmin(
                  image: cubit.allDisease[index].image!,
                  index: index,
                  context: context,
                  dialogTitle: context.areYouSureYouWantToDeleteThisDisease ,
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
                  },
                  onPressEdit: (){
                    cubit.getAllCategories();
                    Navigator.push(context, ScaleTransition1( EditDisease(
                      category: cubit.allDisease[index].category!.name!,
                      categoryId: cubit.allDisease[index].categoryId!,
                      info: cubit.allDisease[index].info!,
                      id: cubit.allDisease[index].id!,
                      diseaseName: cubit.allDisease[index].name!,
                      reasons: cubit.allDisease[index].reasons!,
                      symptoms: cubit.allDisease[index].symptoms!,
                      treatments: cubit.allDisease[index].treatments!,
                    )),
                    );
                  },
                  ),
              itemCount: cubit.allDisease.length,
            ),
          ),
        );
      },
    );
  }
}



