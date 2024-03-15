import 'package:bloc/bloc.dart';
import 'package:tomatopia/api_models/auth_models/login_model.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/cubit/auth_cubit/login/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(this.tomatopiaServices):super(LoginInitialState());
  TomatopiaServices tomatopiaServices ;
  LoginModel? loginModel;
  login({
    required String endPoint,
    required Map<String,dynamic>data,

}){
    emit(LoginLoadingState());
    tomatopiaServices.postData(endPoint: endPoint, data: data).then((value) {

      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.name);
      emit(LoginSuccessState());
    }).catchError((onError){
      print('catch error her : $onError');
      emit(LoginFailureState());
    });
  }
}