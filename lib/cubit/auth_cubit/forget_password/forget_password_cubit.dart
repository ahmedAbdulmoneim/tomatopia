import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tomatopia/api_models/auth_models/forget_password.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/cubit/auth_cubit/forget_password/forget_password_states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit(this.tomatopiaServices)
      : super(ForgetPasswordInitialState());

  TomatopiaServices tomatopiaServices;

  ForgetPasswordModel? forgetPasswordModel;

  checkEmail({
    required String email,
  }) {
    emit(ForgetPasswordLoadingState());
    tomatopiaServices.getData(endPoint: forgetPassword, query: {
      'email': email
    }).then((value) {
      forgetPasswordModel = ForgetPasswordModel.fromJson(value.data);
      print(forgetPasswordModel!.confirmCode);
      emit(ForgetPasswordSuccessState());
    }).catchError((onError) {
      print('check email error : $onError');
      emit(ForgetPasswordFailuerState());
    });
  }

  resetPassword({
    required String newPassword,
    required String confirmPassword,
    required String email,
    required String resetPasswordToken,
}) {
    emit(ResetPasswordLoadingState());
    tomatopiaServices.postData(
        endPoint: resetPasswordEndPoint,
        data: {
          "newPassword": newPassword,
          "newConfirmPassword": confirmPassword,
          "email": email,
          "token": resetPasswordToken
        }
    ).then((value) {
      print(value.data);
      emit(ResetPasswordSuccessState());
    }).catchError((onError){
      print('reset password error : $onError');
      emit(ResetPasswordFailuerState());
    });
  }

  bool isSecure = true;

  IconData suffix = Icons.visibility_off_outlined;

  changePasswordVisibility() {
    isSecure = !isSecure;
    suffix =
    isSecure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
