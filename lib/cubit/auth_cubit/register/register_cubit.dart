import 'package:bloc/bloc.dart';
import 'package:tomatopia/api_models/auth_models/login_model.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/cubit/auth_cubit/register/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(this.tomatopiaServices) : super(RegisterInitialState());
  TomatopiaServices tomatopiaServices;

  LoginModel? loginModel;

  register({
    required String endPoint,
    required Map<String, dynamic> data,
  }) {
    emit(RegisterLoadingState());
    tomatopiaServices.postData(endPoint: endPoint, data: data).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.name);
      emit(RegisterSuccessState());
    }).catchError((onError) {
      print('catch error her : $onError');
      emit(RegisterFailureState());
    });
  }
}
