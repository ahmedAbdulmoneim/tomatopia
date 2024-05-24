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

  getUserProfile() {
    emit(ProfileLoadingState());
    tomatopiaServices.getData(endPoint: profile,token: token).then((value){
      print(value.data);
      profileModel = ProfileModel.fromJson(value.data);
      debugPrint('${profileModel!.image}');
      userImage = profileModel!.image;
      emit(ProfileSuccessState());
    }).catchError((onError){
      debugPrint("get user profile error : $onError");
      emit(ProfileFailureState());
    });
  }

  String? newName ;
  changeUserName({required String newName}) {
    emit(ChangeNameLoadingState());
    tomatopiaServices.update(
        endPoint: changeName,
        token: token,
        query: {"NewName": newName}).then((value) {
          print(value.data);
      profileModel = ProfileModel.fromJson(value.data);
      userName = profileModel!.name;
      newName = profileModel!.name;
      emit(ChangeNameSuccessState());
    }).catchError((onError) {
      print('change name error $onError');
      emit(ChangeNameFailureState());
    });
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
      print(changePasswordModel!.message);
      emit(ChangePasswordSuccessState());
    }).catchError((onError) {
      print('change password error $onError');
      emit(ChangePasswordFailuerState());
    });
  }

  bool isSecure = true;
  IconData suffixIcon = Icons.visibility_off_outlined;

  suffixFunction() {
    isSecure = !isSecure;
    suffixIcon = isSecure
        ? Icons.visibility_off_outlined
        : Icons.remove_red_eye_outlined;
    emit(SuffixIconVisibility());
  }
}
