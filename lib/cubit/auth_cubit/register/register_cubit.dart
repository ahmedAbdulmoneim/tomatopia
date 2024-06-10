import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tomatopia/api_models/auth_models/register_model.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/cubit/auth_cubit/register/register_states.dart';

import '../../../constant/variables.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(this.tomatopiaServices) : super(RegisterInitialState());
  TomatopiaServices tomatopiaServices;

  RegisterModel? registerModel;


  register({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    emit(RegisterLoadingState());
try{
    final response = await tomatopiaServices.postData(
      data: data,
      endPoint: registerEndpoint,
      token: token,
    );
    // Parse the response and update profileModel
    registerModel = RegisterModel.fromJson(response.data);
    if(registerModel!.userId != null){
      userId = registerModel!.userId!;
      userImage = '';
    }
    emit(RegisterSuccessState());
  } catch (onError) {
  debugPrint('catch error her : $onError');
  emit(RegisterFailureState());
  }
}
  bool isSecure = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    isSecure = !isSecure;
    suffix =
        isSecure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeRegisterPasswordVisibility());
  }
}
