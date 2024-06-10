import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_states.dart';
import 'package:tomatopia/custom_widget/custom_button.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'package:tomatopia/custom_widget/toasts.dart';

import '../../custom_widget/text_form_filed.dart';

class AddDisease extends StatefulWidget {
  const AddDisease({Key? key}) : super(key: key);

  @override
  State<AddDisease> createState() => _AddDiseaseState();
}

class _AddDiseaseState extends State<AddDisease> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController symptomsController = TextEditingController();
  final TextEditingController infoController = TextEditingController();
  final TextEditingController reasonsController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  File? imageFile;
  FormData? formData;

  // State variable to store selected category ID
  int? selectedCategoryId;
  List<int> selectedTreatmentIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(context.addDiseaseButton),
      ),
      body: BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {
          if (state is AddDiseaseLoadingState) {
            btnController.start(); // Start loading animation
          } else if (state is AddDiseaseSuccessState) {
            btnController.success(); // Show success animation
            show(context, context.done, context.diseaseAddedSuccessfully, Colors.green);
            nameController.clear();
            symptomsController.clear();
            infoController.clear();
            reasonsController.clear();
            imageFile = null;
            formData = null;
            setState(() {
              selectedCategoryId = null;
              selectedTreatmentIds = [];
            });
            BlocProvider.of<AdminCubit>(context).getAllDisease();
            Navigator.pop(context);
          } else if (state is AddDiseaseFailureState) {
            btnController.error(); // Show error animation
            show(context, context.error, context.failedToAddDisease, Colors.red);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<AdminCubit>(context);
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                   Center(
                    child: Text(
                      context.enterDiseaseDetails,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  textFormField(
                    label: context.name,
                    prefix: Icons.person,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return context.enterValidName;
                      }
                      return null;
                    },
                    controller: nameController,
                  ),
                  const SizedBox(height: 20),
                  bigTextFormFiled(
                    controller: infoController,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return context.enterValidInformation;
                      }
                      return null;
                    },
                    hint: context.info,
                  ),
                  const SizedBox(height: 20),
                  bigTextFormFiled(
                    controller: symptomsController,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return context.enterValidSymptoms;
                      }
                      return null;
                    },
                    hint: context.symptoms,
                  ),

                  const SizedBox(height: 20),
                  bigTextFormFiled(
                    controller: reasonsController,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return context.enterValidReasons;
                      }
                      return null;
                    },
                    hint: context.reasons,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField2<int>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
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
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                    ),
                    hint:  Text(
                      context.selectCategory,
                      style: const TextStyle(fontSize: 14),
                    ),
                    value: selectedCategoryId,
                    onChanged: (value) {
                      setState(() {
                        selectedCategoryId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return context.selectCategory;
                      }
                      return null;
                    },
                    items: cubit.categoryList.map((category) {
                      return DropdownMenuItem<int>(
                        value: category.id,
                        child: Text(category.name),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  MultiSelectDialogField<int>(
                    items: cubit.treatmentList.map((treatment) {
                      return MultiSelectItem<int>(treatment.id, treatment.name);
                    }).toList(),
                    title:  Text(context.selectTreatments),
                    selectedColor: Colors.green,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    buttonIcon: const Icon(
                      Icons.medical_services,
                      color: Colors.green,
                    ),
                    buttonText:  Text(
                      context.selectTreatments,

                    ),
                    onConfirm: (values) {
                      selectedTreatmentIds = values;
                    },
                    validator: (values) {
                      if (values == null || values.isEmpty) {
                        return context.selectAtLeastOneTreatment;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  imageFile != null
                      ? Stack(
                    children: [
                      Image.file(imageFile!),
                      Positioned(
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
                    text: context.loadImage,
                    onPressed: () async {
                      await pickImageFromGallery();
                    },
                  ),
                  const SizedBox(height: 25),
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
                            BlocProvider.of<AdminCubit>(context).addDisease(
                              name: nameController.text,
                              info: infoController.text,
                              reasons: reasonsController.text,
                              categoryId: selectedCategoryId!,
                              treatments: selectedTreatmentIds,
                              symptoms: symptomsController.text,
                              imageFile: imageFile!,
                            );
                            btnController.start();
                          } else {
                            show(context, context.error, context.pleaseSelectImage, Colors.red);
                          }
                        }
                      },
                      child:  Text(
                        context.addDiseaseButton,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future pickImageFromGallery() async {
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
      debugPrint("Didn't select an image");
    }
  }
}
