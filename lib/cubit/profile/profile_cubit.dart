import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/cubit/profile/profile_states.dart';

import '../../api_models/profile_model.dart';
import '../../constant/variables.dart';
import '../../constant/endpints.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this.tomatopiaServices) : super(ProfileInitialState());

  TomatopiaServices tomatopiaServices;
  ProfileModel? profileModel;

  userData() {
    emit(ProfileLoadingState());
    tomatopiaServices.getData(endPoint: profile, token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print(profileModel!.email);
      emit(ProfileSuccessState());
    }).catchError((onError) {
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
  Future picImageFromCamera() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });
      emit(PicProfileImageState());
    } else {
      debugPrint("No image selected from camera");
    }
  }

  addUserImage({required FormData data}){
    emit(AddProfileImageLoadingState());
    tomatopiaServices.postData(endPoint: addUserProfileImage,token:  token, data: data).then((value) {
      debugPrint("${value.data}");
      emit(AddProfileImageSuccessState());
    }).catchError((onError){
      debugPrint("add profile image error : $onError");
      emit(AddProfileImageFailureState());
    });
  }
  void clearSelectedImage() {
    imageFile = null;
    emit(DeleteUserImage());
  }
}
