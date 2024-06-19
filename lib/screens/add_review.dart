import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/cubit/home_cubit/home_cubit.dart';
import 'package:tomatopia/cubit/home_cubit/home_states.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import '../custom_widget/custom_button.dart';
import '../custom_widget/text_form_filed.dart';


class AddReview extends StatelessWidget {
  AddReview({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.addReview),
          centerTitle: true,
        ),
        body: BlocConsumer<HomeCubit, HomePageStates>(
          listener: (context, state) {
            if (state is AddReviewSuccessState) {
              reviewController.clear();
              Fluttertoast.showToast(
                msg: context.done,
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 5,
                textColor: Colors.white,
                fontSize: 16.5,
                gravity: ToastGravity.CENTER,
              );
            }
            if (state is AddReviewFailureState) {
              Fluttertoast.showToast(
                msg: context.error,
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 5,
                textColor: Colors.white,
                fontSize: 16.5,
                gravity: ToastGravity.CENTER,
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      context.addReview,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  textFormField(
                    onSaved: (value) {},
                    label: context.addReview,
                    prefix: Icons.rate_review,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return context.thisFieldCannotBeNull;
                      }
                    },
                    keyboardType: TextInputType.text,
                    controller: reviewController,
                  ),
                  const SizedBox(height: 20),
                  ConditionalBuilder(
                    condition: state is! AddReviewLoadingState,
                    builder: (context) => customButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await BlocProvider.of<HomeCubit>(context)
                              .addReview(review: reviewController.text);
                        }
                      },
                      text: context.sendRev,
                    ),
                    fallback: (context) => Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                        color: Colors.green,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
