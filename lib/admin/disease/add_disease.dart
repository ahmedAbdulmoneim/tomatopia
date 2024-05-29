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
            symptomsController.clear();
            infoController.clear();
            reasonsController.clear();
            imageFile = null;
            formData = null;
            setState(() {
              selectedCategoryId = null;
              selectedTreatmentIds = [];
            });
          } else if (state is AddDiseaseFailureState) {
            btnController.error(); // Show error animation
            show(context, "Error", "Failed to add disease", Colors.red);
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
                  const Center(
                    child: Text(
                      'Enter disease details',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  textFormField(
                    label: 'Name',
                    prefix: Icons.person,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return "Enter valid name";
                      }
                      return null;
                    },
                    controller: nameController,
                  ),
                  const SizedBox(height: 20),
                  textFormField(
                    label: 'Info',
                    prefix: Icons.info,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return "Enter valid information";
                      }
                      return null;
                    },
                    controller: infoController,
                  ),
                  const SizedBox(height: 20),
                  textFormField(
                    label: 'Symptoms',
                    prefix: Icons.add,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return "Enter valid symptoms";
                      }
                      return null;
                    },
                    controller: symptomsController,
                  ),
                  const SizedBox(height: 20),
                  textFormField(
                    label: 'Reasons',
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return "Enter valid reasons";
                      }
                      return null;
                    },
                    prefix: Icons.add,
                    controller: reasonsController,
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
                    hint: const Text(
                      'Select category',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: selectedCategoryId,
                    onChanged: (value) {
                      setState(() {
                        selectedCategoryId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Select category';
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
                    title: const Text('Select Treatments'),
                    selectedColor: Colors.green,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    buttonIcon: const Icon(
                      Icons.medical_services,
                      color: Colors.green,
                    ),
                    buttonText: const Text(
                      'Select treatments',

                    ),
                    onConfirm: (values) {
                      selectedTreatmentIds = values;
                    },
                    validator: (values) {
                      if (values == null || values.isEmpty) {
                        return 'Select at least one treatment';
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
                    text: 'Load Image',
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
                              data: formData!,
                            );
                            btnController.start();
                          } else {
                            show(context, "Error", "Please select an image", Colors.red);
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
