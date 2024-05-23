import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tomatopia/api_models/auth_models/login_model.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/auth_cubit/login/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this.tomatopiaServices) : super(LoginInitialState());
  TomatopiaServices tomatopiaServices;

  LoginModel? loginModel;

  login({
    required String endPoint,
    required Map<String, dynamic> data,
  }) {
    emit(LoginLoadingState());
    tomatopiaServices.postData(endPoint: endPoint, data: data).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      debugPrint(loginModel!.image);
      if(loginModel?.image != null){
        userImage = loginModel!.image;
        userId = loginModel!.userId!;
      }
      emit(LoginSuccessState());
    }).catchError((onError) {
      debugPrint('catch error her : $onError');
      emit(LoginFailureState());
    });
  }

  bool isSecure = true;

  IconData suffix = Icons.visibility_off_outlined;

  changePasswordVisibility() {
    isSecure = !isSecure;
    suffix =
        isSecure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeLoginPasswordVisibilityState());
  }
}
