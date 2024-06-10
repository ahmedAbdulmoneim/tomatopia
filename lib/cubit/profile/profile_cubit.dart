import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/cubit/profile/profile_states.dart';

import '../../api_models/auth_models/change_password_model.dart';
import '../../api_models/profile_model.dart';
import '../../constant/variables.dart';
import '../../constant/endpints.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this.tomatopiaServices) : super(ProfileInitialState());

  TomatopiaServices tomatopiaServices;
  ProfileModel? profileModel;

  Future<void> getUserProfile() async {
    emit(ProfileLoadingState());
    try {
      final response = await tomatopiaServices.getData(
        endPoint: profile,
        token: token,
      );
      // Parse the response and update profileModel
      profileModel = ProfileModel.fromJson(response.data);
      nName = profileModel!.name;
      emit(ProfileSuccessState());
    } catch (error) {
      debugPrint('getUserProfile error $error');
      emit(ProfileFailureState());
    }
  }


  String? nName;

  changeUserName({required String newName}) async {
    emit(ChangeNameLoadingState());
    try {
      var response = await tomatopiaServices.update(
        endPoint: changeName,
        token: token,
        query: {"NewName": newName},
      );
      getUserProfile();
      profileModel = ProfileModel.fromJson(response.data);
      if (profileModel != null) {
        nName = profileModel!.name;
      }
      emit(ChangeNameSuccessState());
    } catch (error) {
      debugPrint('change name error $error');
      emit(ChangeNameFailureState());
    }
  }



  File? imageFile;
  FormData? formData;
  Future picImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result != null) {
      imageFile = File(result.files.single.path!);
      formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile!.path,
          filename: imageFile!.path.split('/').last,
        ),
      });
      emit(LoadProfileImageState());
    } else {
      debugPrint("didn't select an image ");
    }
  }
  Future<void> picImageFromCamera() async {
    try {
      final picker = ImagePicker();
      XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        formData = FormData.fromMap({
          'image': await MultipartFile.fromFile(
            imageFile!.path,
            filename: imageFile!.path.split('/').last,
          ),
        });
        emit(PicProfileImageState());
      } else {
        debugPrint("No image selected from camera");
      }
    } catch (e) {
      debugPrint("Error picking image from camera: $e");
    }
  }



  addUserImage({required File imageFile}) async {
    emit(AddProfileImageLoadingState());
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final response = await tomatopiaServices.postData(
        endPoint: addUserProfileImage,
        token: token,
        data: formData,
      );

      getUserProfile();
      debugPrint("${response.data}");
      emit(AddProfileImageSuccessState());
    } catch (error) {
      debugPrint("add profile image error : $error");
      emit(AddProfileImageFailureState());
    }
  }

  void clearSelectedImage() {
    imageFile = null;
    emit(DeleteUserImage());
  }

  ChangePasswordModel? changePasswordModel;

  void changePassword({
    required Map<String, dynamic> data,
  }) {
    emit(ChangePasswordLoadingState());
    tomatopiaServices
        .postData(endPoint: changePasswordEndPoint, data: data, token: token)
        .then((value) {
      changePasswordModel = ChangePasswordModel.fromJson(value.data);
      debugPrint(changePasswordModel!.message);
      emit(ChangePasswordSuccessState());
    }).catchError((onError) {
      debugPrint('change password error $onError');
      emit(ChangePasswordFailuerState());
    });
  }

  bool isSecure = true;
  IconData suffixIcon = Icons.visibility_off_outlined;

  suffixFunction() {
    isSecure = !isSecure;
    print(isSecure);
    suffixIcon = isSecure
        ? Icons.visibility_off_outlined
        : Icons.remove_red_eye_outlined;
    emit(SuffixIconVisibility());
  }
}
