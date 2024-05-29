import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_states.dart';
import 'package:tomatopia/custom_widget/custom_button.dart';
import 'package:tomatopia/custom_widget/toasts.dart';

import '../../custom_widget/text_form_filed.dart';

class AddDisease extends StatefulWidget {
  const AddDisease({Key? key}) : super(key: key);

  @override
  State<AddDisease> createState() => _AddDiseaseState();
}

class _AddDiseaseState extends State<AddDisease> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  final TextEditingController treatmentController = TextEditingController();
  final TextEditingController symptomsController = TextEditingController();
  final TextEditingController infoController = TextEditingController();
  final TextEditingController reasonsController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  File? imageFile;
  FormData? formData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Disease'),
      ),
      body: BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {
          if (state is AddDiseaseLoadingState) {
            btnController.start(); // Start loading animation
          } else if (state is AddDiseaseSuccessState) {
            btnController.success(); // Show success animation
            show(context, "Done", "Disease added successfully!", Colors.green);
            nameController.clear();
            categoryIdController.clear();
            treatmentController.clear();
            symptomsController.clear();
            infoController.clear();
            reasonsController.clear();
            imageFile = null;
            formData = null;
          } else if (state is AddDiseaseFailureState) {
            btnController.error(); // Show error animation
            show(context, "Error", "Failed to add disease", Colors.red);
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Enter disease details',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textFormField(
                    label: 'Name',
                    prefix: Icons.person,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return "enter valid name ";
                      }
                      return null;
                    },
                    controller: nameController,
                  ),
                  const SizedBox(height: 20),
                  textFormField(
                    label: 'info',
                    prefix: Icons.info,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return "enter valid information ";
                      }
                      return null;
                    },
                    controller: infoController,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextFormField(
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            labelText: 'Category ID ',
                            prefixIcon: const Icon(
                              Icons.category_outlined,
                            ),
                            labelStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            errorStyle: const TextStyle(
                              color: Colors.red,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.green),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "enter valid category ID  ";
                            }
                            return null;
                          },
                          controller: categoryIdController,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextFormField(
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                              labelText: 'treatments ID ',
                              prefixIcon: const Icon(
                                Icons.medical_information_outlined,
                              ),
                              labelStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  )),
                              errorStyle: const TextStyle(
                                color: Colors.red,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.green))),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "enter valid treatment ID  ";
                            }
                            return null;
                          },
                          controller: treatmentController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textFormField(
                    label: 'symptoms',
                    prefix: Icons.add,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return "enter valid symptoms ";
                      }
                      return null;
                    },
                    controller: symptomsController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textFormField(
                    label: 'reasons',
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return "enter valid reasons ";
                      }
                      return null;
                    },
                    prefix: Icons.add,
                    onSaved: (value) {},
                    controller: reasonsController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  imageFile != null
                      ? Stack(
                          children: [
                            Image.file(imageFile!),
                            Positioned(
                              // Adjust positioning as needed
                              right: 0.0,
                              child: IconButton(
                                icon: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black54,
                                  ),
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    imageFile = null;
                                    formData = null;
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      : customButton(
                          width: 100,
                          text: 'Load Image',
                          onPressed: () async {
                            await picImageFromGallery();
                          },
                        ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: 100,
                    child: RoundedLoadingButton(
                      successColor: Colors.green,
                      animateOnTap: false,
                      borderRadius: 20.0,
                      color: Colors.grey[300],
                      controller: btnController,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (imageFile != null) {
                            formKey.currentState!.save();
                            int categoryId =
                                int.parse(categoryIdController.text);
                            int treatmentsId =
                                int.parse(treatmentController.text);
                            BlocProvider.of<AdminCubit>(context).addDisease(
                              name: nameController.text,
                              info: infoController.text,
                              reasons: reasonsController.text,
                              categoryId: categoryId,
                              treatments: treatmentsId,
                              symptoms: symptomsController.text,
                              data: formData!,
                            );
                            btnController.start();
                          } else if (imageFile == null) {
                            show(context, "Error", "Please select an image",
                                Colors.red);
                          }
                        }
                      },
                      child: const Text(
                        'Add Disease',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future picImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result != null) {
      imageFile = File(result.files.single.path!);
      formData = FormData.fromMap({
        'Image': await MultipartFile.fromFile(
          imageFile!.path,
          filename: imageFile!.path.split('/').last,
        ),
      });
      setState(() {});
    } else {
      debugPrint("didn't select an image ");
    }
  }
}
