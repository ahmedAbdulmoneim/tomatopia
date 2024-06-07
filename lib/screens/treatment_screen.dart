import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatopia/cubit/ai_cubit/ai_model_cubit.dart';
import 'package:tomatopia/custom_widget/custom_button.dart';

import '../constant/carousal_items.dart';
import '../cubit/ai_cubit/ai_model_state.dart';

class GetMedicine extends StatefulWidget {
  GetMedicine({Key? key, required this.img}) : super(key: key);
  File img;


  @override
  State<GetMedicine> createState() => _GetMedicineState();
}

class _GetMedicineState extends State<GetMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AiCubit,AiModelStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          widget.img,
                          fit: BoxFit.cover,
                          height: 250,
                          width: double.infinity,
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      // cubit.aiModel!.prediction == null? '' : 'Prediction :  ${cubit.aiModel!.prediction}',
                      'prediction',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        customButton(
                            width: 50,
                            text: 'Load picture',
                            onPressed: () async {

                              await picImageFromGallery();
                              widget.img = selectedImage!;
                            }),
                        const Spacer(),
                        customButton(
                            width: 50,
                            text: 'Take picture',
                            onPressed: () async {
                              await picImageFromCamera();
                              widget.img = selectedImage!;
                            }),
                        const Spacer()
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        },

      ),
    );
  }

  Future picImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  Future picImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  void clearSelectedImage() {
    setState(() {
      selectedImage = null;
    });
  }
}
