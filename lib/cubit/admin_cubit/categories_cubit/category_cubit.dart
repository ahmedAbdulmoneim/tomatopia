import 'package:bloc/bloc.dart';
import 'package:tomatopia/api_models/admin_models/category_model.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/admin_cubit/categories_cubit/category_states.dart';

class CategoryCubit extends Cubit<CategoryStates>{
  CategoryCubit(this.tomatopiaServices):super(GetAllCategoryInitialState());

  TomatopiaServices tomatopiaServices ;
  List<dynamic>? categoryList ;
  
  getAllCategories(){
    emit(GetAllCategoryLoadingState());
    tomatopiaServices.getData(endPoint: getAllCat,token: token).then((value){
      categoryList = value.data;
      print(categoryList![0]['name']);
      emit(GetAllCategorySuccessState());
    }).catchError((onError){
      print('get all category error : $onError');
      emit(GetAllCategoryFailureState());
    });
  }
}