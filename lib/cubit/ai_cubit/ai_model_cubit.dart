import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatopia/api_models/ai_model.dart';
import 'package:tomatopia/api_services/model_services.dart';
import 'package:tomatopia/cubit/ai_cubit/ai_model_state.dart';

class AiCubit extends Cubit<AiModelStates> {
  AiCubit(this.aiModelServices) : super(AiModelInitialState());

  AIModelServices aiModelServices;
  AiModel? aiModel;

  postData({required File imageFile}) async{
    emit(AiModelLoadingState());
    try {
      FormData formData = FormData.fromMap({


        'image_file': await MultipartFile.fromFile(imageFile.path,
            filename: 'image.jpg'),
      });

      var response = await aiModelServices.postDisease(
        data: formData,
      );
      debugPrint(response.data.toString());
      emit(AiModelSuccessState());
    }
    catch (error) {
      debugPrint("Ai Model error : $error");
      emit(AiModelFailureState());
    }


  }

  File? imageFile;
  FormData? formData;

  Future pickImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      imageFile = File(result.files.single.path!);
      formData = FormData.fromMap({
        'image_file': await MultipartFile.fromFile(
          imageFile!.path,
          filename: imageFile!.path.split('/').last,
        ),
      });
      emit(LoadImageGallerySuccessState());
    } else {
      debugPrint("didn't select an image ");
    }
  }

  Future pickImageFromCamera() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      formData = FormData.fromMap({
        'image_file': await MultipartFile.fromFile(
          imageFile!.path,
          filename: imageFile!.path.split('/').last,
        ),
      });
      emit(PicImageCameraSuccessState());
    } else {
      debugPrint("No image selected from camera");
    }
  }

  void clearSelectedImage() {
    imageFile = null;
    formData = null;  // Ensure formData is also cleared
    emit(ClearImageState());
  }

  void navigateToGetMedicineScreen({
    required context,
    required Widget page,
  }) {
    if (imageFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    }
  }
}