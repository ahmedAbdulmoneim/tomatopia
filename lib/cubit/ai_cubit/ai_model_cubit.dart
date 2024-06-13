import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatopia/api_models/ai_model.dart';
import 'package:tomatopia/api_services/model_services.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/cubit/ai_cubit/ai_model_state.dart';

import '../../api_models/admin_models/disease_model.dart';
import '../../constant/variables.dart';

class AiCubit extends Cubit<AiModelStates> {
  AiCubit(this.aiModelServices,this.tomatopiaServices) : super(AiModelInitialState());

  AIModelServices aiModelServices;
  TomatopiaServices tomatopiaServices;
  AiModel? aiModel;
  String? diseaseNameArabic ;

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
      aiModel= AiModel.fromJson(response.data);

      if(aiModel!.prediction != 'bad' ||aiModel!.prediction != 'healthy' ){
        if(aiModel!.prediction == "Mosaic Virus"){
          diseaseNameArabic = "فيروس موازيك";
        }else if(aiModel!.prediction == "Yellow Leaf Curl Virus"){
          diseaseNameArabic = "فيروس تجعد أوراق الطماطم الصفراء";
        }else if(aiModel!.prediction == "Target Spot"){
          diseaseNameArabic = "البقعة المستهدفة";
        }else if(aiModel!.prediction == "Spider Mites"){
          diseaseNameArabic = "عث العنكبوت";
        }else if(aiModel!.prediction == "Septoria Leaf Spot"){
          diseaseNameArabic = "بقعة اوراق سبتوريا";
        }else if(aiModel!.prediction == "Leaf Mold"){
          diseaseNameArabic = "عفن أوراق الطماطم";
        }else if(aiModel!.prediction == "Late Blight"){
          diseaseNameArabic = "اللفحة المتأخرة";
        }else if(aiModel!.prediction == "Early Blight"){
          diseaseNameArabic = "اللفحة المبكر";
        }else if(aiModel!.prediction == "Bacterial Spot"){
          diseaseNameArabic = "البقع البكتيرية";
        }else{
          diseaseNameArabic = '';
        }
      }

      debugPrint(aiModel!.prediction);
      emit(AiModelSuccessState());
    }
    catch (error) {
      debugPrint("Ai Model error : $error");
      emit(AiModelFailureState());
    }


  }

  List<dynamic> searchData = [];
  List<DiseaseModel> diseaseInfo = [];

  Future<void> getDiseaseInfo({required String name}) async {
    emit(GetDiseaseInfoLoadingState());
    try {
      final value = await tomatopiaServices.getData(
        endPoint: getDiseaseByNameEndpoint,
        token: token,
        query: {'name': name},
      );
      searchData = value.data;
      diseaseInfo.clear();
      for (int i = 0; i < searchData.length; i++) {
        diseaseInfo.add(DiseaseModel.fromJson(searchData[i]));
      }
      print(diseaseInfo[0].reasons);
      emit(GetDiseaseInfoSuccessState());
    } catch (onError) {
      debugPrint('get disease by name error : $onError');
      emit(GetDiseaseInfoFailureState());
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

  Future<void> showAdviceDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('please'.tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

                Text('camera_Advice'.tr()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ok'.tr(),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> pickImageFromCamera(BuildContext context) async {
    final picker = ImagePicker();

    // Show the advice dialog before picking the image
    await showAdviceDialog(context);

    XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      formData = FormData.fromMap({
        'image_file': await MultipartFile.fromFile(
          imageFile!.path,
          filename: imageFile!.path.split('/').last,
        ),
      });
      // Assuming you have a Bloc or similar state management to handle this state
      // emit(PicImageCameraSuccessState());
      debugPrint("Image successfully picked from camera");
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