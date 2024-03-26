import 'package:bloc/bloc.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/cubit/profile/profile_states.dart';

import '../../api_models/profile_model.dart';
import '../../constant/variables.dart';
import '../../constant/endpints.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit(this.tomatopiaServices):super(ProfileInitialState());

  TomatopiaServices tomatopiaServices;
  ProfileModel? profileModel;

  userData(){
    emit(ProfileLoadingState());
    tomatopiaServices.getData(endPoint: profile,token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print(profileModel!.email);
      emit(ProfileSuccessState());
    }).catchError((onError){
      print('profile error $onError');
      emit(ProfileFailureState());
    });
  }
}