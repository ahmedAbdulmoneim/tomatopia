import 'package:bloc/bloc.dart';
import 'package:tomatopia/api_models/admin_models/delete_model.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/admin_cubit/categories_cubit/category_states.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit(this.tomatopiaServices) : super(GetAllCategoryInitialState());

  TomatopiaServices tomatopiaServices;

  List<dynamic>? categoryList;

  getAllCategories() {
    emit(GetAllCategoryLoadingState());
    tomatopiaServices.getData(endPoint: getAllCat, token: token).then((value) {
      categoryList = value.data;
      emit(GetAllCategorySuccessState());
    }).catchError((onError) {
      emit(GetAllCategoryFailureState());
    });
  }

  DeleteModel? deleteModel;

  deleteCategory({required int id}) {
    emit(DeleteCategoryLoadingState());
    tomatopiaServices.deleteRequest(
        token: token, endpoint: deleteCat, query: {'id': '$id'}).then((value) {
      deleteModel = DeleteModel.fromJson(value.data);
      emit(DeleteCategorySuccessState());
    }).catchError((onError) {
      emit(DeleteCategoryFailureState());
    });
  }

  DeleteModel? editModel;

  editeCategory({required int id, required String newCategory}) {
    emit(EditeCategoryLoadingState());
    tomatopiaServices.update(
      endPoint: 'Category/EditCategory',
      token: token,
      data: {"id": id, "name": newCategory},
    ).then((value) {
      editModel = DeleteModel.fromJson(value.data);
      emit(EditeCategorySuccessState());
    }).catchError((onError) {
      emit(EditeCategoryFailureState());
    });
  }
}
