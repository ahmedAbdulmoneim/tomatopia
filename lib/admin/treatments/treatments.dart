import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/admin/treatments/add_treatments.dart';
import 'package:tomatopia/admin/treatments/edit_treatments.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import '../../../cubit/admin_cubit/admin_cubit.dart';
import '../../../cubit/admin_cubit/admin_states.dart';
import '../../../custom_widget/toasts.dart';
import '../../../page_transitions/scale_transition.dart';

class Treatments extends StatelessWidget {
  const Treatments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if(state is DeleteTreatmentSuccessState){
          show(context, context.done, context.deleteTreatmentSuccess, Colors.green);
          BlocProvider.of<AdminCubit>(context).getAllTreatment();
        }
        if(state is DeleteTreatmentFailureState){
          show(context,context.error, context.errorHappened, Colors.red);
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<AdminCubit>(context);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title:  Text(context.allTreatments),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      SizeTransition1( AddTreatments()));
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
            condition: state is GetAlTreatmentLoadingState ,
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.treatmentList[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                cubit.treatmentList[index].description,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){
                                Navigator.push(context, SizeTransition1(EditTreatment(
                                  description: cubit.treatmentList[index].description,
                                  title: cubit.treatmentList[index].name,
                                  id: cubit.treatmentList[index].id,
                                ),
                                ),);
                              },
                              icon: const Icon(
                                FontAwesomeIcons.solidPenToSquare,color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  btnOkOnPress: (){
                                     cubit.deleteTreatment(id: cubit.treatmentList[index].id);
                                  },
                                  btnCancelOnPress: () {},
                                  btnCancelText: context.cancel,
                                  btnOkText: context.delete,
                                  btnCancelColor: Colors.green,
                                  btnOkColor: Colors.red,
                                  title: context.deleteTreatmentConfirmation,
                                  animType: AnimType.leftSlide,
                                ).show();
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              itemCount: cubit.treatmentList.length,
            ),
          ),
        );
      },
    );
  }
}
