import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/admin/tips/edit_tip.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/custom_widget/extensions.dart';

import '../../../cubit/admin_cubit/admin_cubit.dart';
import '../../../cubit/admin_cubit/admin_states.dart';
import '../../../custom_widget/toasts.dart';
import '../../../page_transitions/scale_transition.dart';
import 'add_tip.dart';

class Tips extends StatelessWidget {
  const Tips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is DeleteTipSuccessState) {
          show(context, context.done, context.tipDeletedSuccessfully, Colors.green);
          BlocProvider.of<AdminCubit>(context).getAllTips();
        }
        if (state is DeleteTipFailureState) {
          show(context, context.error, context.failedToDeleteTip, Colors.red);
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<AdminCubit>(context);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: Text(context.allTips),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, SizeTransition1(AddTips()));
                },
                icon: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add)),
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: state is GetTipsLoadingState,
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
                          child: Image.network(
                            '$basUrlImage${cubit.allTips[index].image}',
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
                                cubit.allTips[index].title!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                cubit.allTips[index].description!,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                        userEmail == 'Admin@gamil.com' ||
                            userEmail == 'admin@gamil.com'
                            ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  SizeTransition1(
                                    EditTips(
                                      description: cubit
                                          .allTips[index].description!,
                                      title:
                                      cubit.allTips[index].title!,
                                      id: cubit.allTips[index].id!,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                FontAwesomeIcons.solidPenToSquare,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  btnOkOnPress: () {
                                    cubit.deleteTip(
                                        id: cubit.allTips[index].id);
                                  },
                                  btnCancelOnPress: () {},
                                  btnCancelText: context.cancel,
                                  btnOkText: context.delete,
                                  btnCancelColor: Colors.green,
                                  btnOkColor: Colors.red,
                                  title: context.deleteTipConfirmation,
                                  animType: AnimType.leftSlide,
                                ).show();
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        )
                            : const Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                  ),
                ),
              ),
              itemCount: cubit.allTips.length,
            ),
          ),
        );
      },
    );
  }
}
