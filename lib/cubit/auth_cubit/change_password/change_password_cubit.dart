import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tomatopia/api_models/auth_models/change_password_model.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/cubit/auth_cubit/change_password/change_password_states.dart';

import '../../../constant/constant.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit(this.tomatopiaServices)
      : super(ChangePasswordInitialState());

  TomatopiaServices tomatopiaServices;
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
