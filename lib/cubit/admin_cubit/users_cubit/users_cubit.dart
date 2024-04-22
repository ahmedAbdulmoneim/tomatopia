import 'package:bloc/bloc.dart';
import 'package:tomatopia/api_models/admin_models/delete_model.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/admin_cubit/users_cubit/users_states.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit(this.tomatopiaServices) : super(GetAllUsersInitialState());

  TomatopiaServices tomatopiaServices;
  List<dynamic>? userModel;
  DeleteModel? deleteModel;


  showAllUsers({
    required dynamic pageSize,
    required dynamic pageNumber,
  }) {
    emit(GetAllUsersLoadingState());
    tomatopiaServices.getData(endPoint: getAllUsers, token: token, query: {
      'pageSize': pageSize,
      'pageNumber': pageNumber,
    }).then((value) {
      userModel = value.data;
      emit(GetAllUsersSuccessState());
    }).catchError((onError) {
      print('get all users error : $onError');
      emit(GetAllUsersFailuerState());
    });
  }

  deleteUser({required String email}) {
    emit(DeleteUsersLoadingState());
    tomatopiaServices
        .deleteRequest(
      token: token,
      query: {'email': email},
      endpoint: 'Account/DeleteUser',
    )
        .then((value) {
      deleteModel = DeleteModel.fromJson(value.data);
      emit(DeleteUsersSuccessState());
      emit(GetAllUsersSuccessState());
    }).catchError((onError) {
      print('delete user error : $onError');
      emit(DeleteUsersFailuerState());
    });
  }

  int currentPage = 0 ;
  onPageChange(int index){
 currentPage = index;
 emit(OnPageChange());
  }
}
