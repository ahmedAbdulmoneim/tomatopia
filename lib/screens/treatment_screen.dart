import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/cubit/ai_cubit/ai_model_cubit.dart';
import 'package:tomatopia/custom_widget/custom_card_user.dart';
import 'package:tomatopia/screens/user_disease_details.dart';

import '../cubit/ai_cubit/ai_model_state.dart';
import '../notification/send_notification.dart';
import '../page_transitions/scale_transition.dart';

class GetMedicine extends StatefulWidget {
  const GetMedicine({Key? key, required this.img}) : super(key: key);
  final File img;

  @override
  State<GetMedicine> createState() => _GetMedicineState();
}

class _GetMedicineState extends State<GetMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AiCubit, AiModelStates>(
        listener: (context, state) async {
          if (state is GetDiseaseInfoSuccessState) {
            LocationPermission permission = await Geolocator.checkPermission();
            if (permission == LocationPermission.denied) {
              AwesomeDialog(
                  context: context,
                  title:
                      'are you allow to send notification to users behind you to alert them ',
                  dialogType: DialogType.question,
                  btnOkOnPress: () {
                    BlocProvider.of<AiCubit>(context).getLocation();
                  }).show();
            } else {
              BlocProvider.of<AiCubit>(context).getLocation();
            }
          }
          if (state is GetUserLocationSuccess) {
            BlocProvider.of<AiCubit>(context).getNearestUserLocation(
                late: BlocProvider.of<AiCubit>(context).userLocationLate,
                long: BlocProvider.of<AiCubit>(context).userLocationLong);
          }
          if (state is GetNearestLocationSuccessState) {
            sendMessage(BlocProvider.of<AiCubit>(context).uniqueTokens,BlocProvider.of<AiCubit>(context).diseaseInfo[0].name);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<AiCubit>(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      widget.img,
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                    )),
              ),
              const SizedBox(
                height: 25,
              ),
              ConditionalBuilder(
                condition: state is GetDiseaseInfoLoadingState,
                builder: (context) => Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.green,
                    size: 50,
                  ),
                ),
                fallback: (context) => Expanded(
                  child: ListView.builder(
                    itemCount: cubit.diseaseInfo.length,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            ScaleTransition1(
                              UserDiseaseDetails(index: index),
                            ),
                          );
                        },
                        child: customCard(
                          image: cubit.diseaseInfo[index].image!,
                          index: index,
                          context: context,
                          mainTitle: cubit.diseaseInfo[index].name!,
                          subtitle: cubit.diseaseInfo[index].category!.name!,
                        )),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
