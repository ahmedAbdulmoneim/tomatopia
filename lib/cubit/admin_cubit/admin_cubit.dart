import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:tomatopia/api_models/admin_models/delete_model.dart';
import 'package:tomatopia/api_models/admin_models/get_users_model.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_states.dart';
import '../../api_models/admin_models/category_model.dart';
import '../../api_models/admin_models/disease_model.dart';
import '../../api_models/admin_models/treatment_model.dart';
import '../../api_models/tips_model.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit(this.tomatopiaServices) : super(GetAllUsersInitialState());

  TomatopiaServices tomatopiaServices;
  AllUserModel? userModel;
  DeleteModel? deleteModel;
  int numberOfPages = 1;

  Future<void> showAllUsers({
    required dynamic pageSize,
    required dynamic pageNumber,
  }) async {
    emit(GetAllUsersLoadingState());
    try {
      final value = await tomatopiaServices.getData(
        endPoint: getAllUsers,
        token: token,
        query: {'pageSize': pageSize, 'pageNumber': pageNumber},
      );
      userModel = AllUserModel.fromJson(value.data);
      numberOfPages = userModel!.usersNumber!;
      emit(GetAllUsersSuccessState());
    } catch (onError) {
      debugPrint('get all users error : $onError');
      emit(GetAllUsersFailuerState());
    }
  }

  Future<void> deleteUser({required String email}) async {
    emit(DeleteUsersLoadingState());
    try {
      final value = await tomatopiaServices.deleteRequest(
        token: token,
        query: {'email': email},
        endpoint: 'Account/DeleteUser',
      );
      deleteModel = DeleteModel.fromJson(value.data);
      emit(DeleteUsersSuccessState());
      emit(GetAllUsersSuccessState());
    } catch (onError) {
      debugPrint('delete user error : $onError');
      emit(DeleteUsersFailuerState());
    }
  }

  int currentPage = 0;
  void onPageChange(int index) {
    currentPage = index;
    emit(OnPageChange());
  }

  // Category
  CategoryModel? categoryModel;
  List<dynamic> categories = [];
  List<CategoryModel> categoryList = [];

  Future<void> getAllCategories() async {
    emit(GetAllCategoryLoadingState());
    try {
      final value = await tomatopiaServices.getData(endPoint: getAllCat, token: token);
      categories = value.data;
      categoryList.clear();
      for (int i = 0; i < categories.length; i++) {
        categoryList.add(CategoryModel.fromJson(categories[i]));
      }
      emit(GetAllCategorySuccessState());
    } catch (onError) {
      emit(GetAllCategoryFailureState());
    }
  }

  DeleteModel? deleteCategoryModel;
  Future<void> deleteCategory({required int id}) async {
    emit(DeleteCategoryLoadingState());
    try {
      final value = await tomatopiaServices.deleteRequest(
        token: token,
        endpoint: deleteCat,
        query: {'id': '$id'},
      );
      deleteCategoryModel = DeleteModel.fromJson(value.data);
      emit(DeleteCategorySuccessState());
    } catch (onError) {
      emit(DeleteCategoryFailureState());
    }
  }

  DeleteModel? editModel;
  Future<void> editCategory({required int id, required String newCategory}) async {
    emit(EditeCategoryLoadingState());
    try {
      final value = await tomatopiaServices.update(
        endPoint: 'Category/EditCategory',
        token: token,
        data: {"id": id, "name": newCategory},
      );
      editModel = DeleteModel.fromJson(value.data);
      emit(EditeCategorySuccessState());
    } catch (onError) {
      emit(EditeCategoryFailureState());
    }
  }

  DeleteModel? addModel;
  Future<void> addCategory({required String newCategory}) async {
    emit(AddCategoryLoadingState());
    try {
      final value = await tomatopiaServices.postData(
        endPoint: addCat,
        data: {"name": newCategory},
        token: token,
      );
      addModel = DeleteModel.fromJson(value.data);
      emit(AddCategorySuccessState());
    } catch (onError) {
      debugPrint('add category error : $onError');
      emit(AddCategoryFailureState());
    }
  }

  // Diseases
  DiseaseModel? diseaseModel;
  List<dynamic> data = [];
  List<DiseaseModel> allDisease = [];

  Future<void> getAllDisease() async {
    emit(GetAllDiseaseLoadingState());
    try {
      final response = await tomatopiaServices.getData(
        endPoint: getAllDiseaseEndpoint,
        token: token,
      );
      data = response.data;
      allDisease.clear();
      for (int i = 0; i < data.length; i++) {
        allDisease.add(DiseaseModel.fromJson(data[i]));
      }
      emit(GetAllDiseaseSuccessState());
    } catch (onError) {
      debugPrint("get disease error here: $onError");
      emit(GetAllDiseaseFailureState());
    }
  }

  Future<void> addDisease({
    required String name,
    required String info,
    required String reasons,
    required int categoryId,
    required String symptoms,
    required File imageFile,
    required List<int> treatments,
  }) async {
    emit(AddDiseaseLoadingState());
    try {
      FormData formData = FormData.fromMap({
        "Treatments": treatments.map((e) => e.toString()).toList(),
        "CategoryId": categoryId,
        "symptoms": symptoms,
        "info": info,
        "name": name,
        "reasons": reasons,
        'Image': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
      });

      debugPrint('FormData: ${formData.fields}');

      var response = await tomatopiaServices.postData(
        endPoint: addDiseaseEndpoint,
        token: token,
        data: formData,
      );
      debugPrint(response.data.toString());
      emit(AddDiseaseSuccessState());
    } catch (onError) {
      debugPrint('add disease error : $onError');
      emit(AddDiseaseFailureState());
    }
  }

  Future<void> editDisease({
    required int id,
    required String name,
    required String info,
    required String reasons,
    required int categoryId,
    required String symptoms,
    required File imageFile,
    required List<int> treatments,
  }) async {
    emit(AddDiseaseLoadingState());
    try {
      FormData formData = FormData.fromMap({
        "Treatments": treatments.map((e) => e.toString()).toList(),
        "id": id,
        "CategoryId": categoryId,
        "symptoms": symptoms,
        "info": info,
        "name": name,
        "reasons": reasons,
        'Image': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
      });

      debugPrint('FormData: ${formData.fields}');

      var response = await tomatopiaServices.update(
        endPoint: editDiseaseEndPoint,
        token: token,
        data: formData,
      );
      debugPrint(response.data.toString());
      emit(EditDiseaseSuccessState());
    } catch (onError) {
      debugPrint('edit disease error : $onError');
      emit(EditDiseaseFailureState());
    }
  }

  List<dynamic> searchData = [];
  List<DiseaseModel> searchedDisease = [];

  Future<void> getDiseaseByName({required String name}) async {
    emit(GetDiseaseByNameLoadingState());
    try {
      final value = await tomatopiaServices.getData(
        endPoint: getDiseaseByNameEndpoint,
        token: token,
        query: {'name': name},
      );
      searchData = value.data;
      for (int i = 0; i < searchData.length; i++) {
        searchedDisease.add(DiseaseModel.fromJson(searchData[i]));
      }
      debugPrint('treatments : ${value.data[0]['category']}');
      emit(GetDiseaseByNameSuccessState());
    } catch (onError) {
      debugPrint('get disease by name error : $onError');
      emit(GetDiseaseByNameFailureState());
    }
  }

  void clearSearchedDisease() {
    searchedDisease.clear();
    emit(ClearSearchedDisease());
  }

  Future<void> deleteDiseases({required int id}) async {
    emit(DeleteDiseaseLoadingState());
    try {
      final value = await tomatopiaServices.deleteRequest(
        token: token,
        endpoint: deleteDisease,
        query: {'id': id},
      );
      debugPrint("${value.data}");
      allDisease.clear();
      emit(DeleteDiseaseSuccessState());
      emit(GetAllDiseaseSuccessState());
    } catch (onError) {
      debugPrint("delete disease error : $onError");
      emit(DeleteDiseaseFailureState());
    }
  }

  // Treatment
  List<dynamic> treatments = [];
  List<TreatmentModel> treatmentList = [];

  Future<void> getAllTreatment() async {
    emit(GetAlTreatmentLoadingState());
    try {
      final value = await tomatopiaServices.getData(
        endPoint: getAllTreatmentEndPoint,
        token: token,
      );
      treatments = value.data;
      treatmentList.clear();
      for (int i = 0; i < treatments.length; i++) {
        treatmentList.add(TreatmentModel.fromJson(treatments[i]));
      }
      emit(GetAllTreatmentSuccessState());
    } catch (onError) {
      debugPrint('get treatment error : $onError');
      emit(GetAllTreatmentFailureState());
    }
  }

  Future<void> deleteTreatment({required id}) async {
    emit(DeleteTreatmentLoadingState());
    try {
      await tomatopiaServices.deleteRequest(
        token: token,
        endpoint: deleteTreatmentEndPoint,
        query: {"id": id},
      );
      emit(DeleteTreatmentSuccessState());
    } catch (onError) {
      debugPrint("delete treatment error : $onError");
      emit(DeleteTreatmentFailureState());
    }
  }

  Future<void> addTreatment({required name, required description}) async {
    emit(AddTreatmentLoadingState());
    try {
      await tomatopiaServices.postData(
        endPoint: addTreatmentEndPoint,
        data: {
          "name": name,
          "description": description,
        },
        token: token,
      );
      emit(AddTreatmentSuccessState());
    } catch (onError) {
      debugPrint("add treatment error : $onError");
      emit(AddTreatmentFailureState());
    }
  }

  Future<void> editTreatment({required id, required name, required description}) async {
    emit(EditTreatmentLoadingState());
    try {
      await tomatopiaServices.update(
        endPoint: editTreatmentEndPoint,
        data: {
          "id": id,
          "name": name,
          "description": description,
        },
        token: token,
      );
      emit(EditTreatmentSuccessState());
    } catch (onError) {
      debugPrint("edit treatment error : $onError");
      emit(EditTreatmentFailureState());
    }
  }

  File? imageFile;
  FormData? formData;

  Future<void> picImageFromGallery() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
      if (result != null) {
        imageFile = File(result.files.single.path!);
        formData = FormData.fromMap({
          'image': await MultipartFile.fromFile(
            imageFile!.path,
            filename: imageFile!.path.split('/').last,
          ),
        });
        emit(LoadDiseaseImage());
      } else {
        debugPrint("didn't select an image");
      }
    } catch (e) {
      debugPrint("Error selecting image: $e");
    }
  }

  void clearImage() {
    imageFile = null;
    emit(ClearDiseaseImage());
  }

  int? selectedCategoryId;
  void selectCategory(value) {
    selectedCategoryId = value;
    emit(SelectCategoryId());
  }

  // Tips
  List<dynamic> tipsMap = [];
  List<TipsModel> allTips = [];

  Future<void> getAllTips() async {
    emit(GetTipsLoadingState());
    try {
      final value = await tomatopiaServices.getData(endPoint: getTips, token: token);
      tipsMap = value.data;
      allTips.clear();
      for (int i = 0; i < tipsMap.length; i++) {
        allTips.add(TipsModel.fromJson(tipsMap[i]));
      }
      emit(GetTipsSuccessState());
    } catch (onError) {
      debugPrint('ger tips error : $onError');
      emit(GetTipsFailureState());
    }
  }

  Future<void> deleteTip({required id}) async {
    emit(DeleteTipLoadingState());
    try {
      await tomatopiaServices.deleteRequest(
        token: token,
        endpoint: deleteTipEndPoint,
        query: {"id": id},
      );
      emit(DeleteTipSuccessState());
    } catch (onError) {
      debugPrint("delete tip error : $onError");
    }
  }

  Future<void> addTip({required title, required description, required imageFile}) async {
    emit(AddTipLoadingState());
    try {
      FormData formData = FormData.fromMap({
        if (imageFile != null)
          'Image': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
      });
      await tomatopiaServices.postData(
        token: token,
        endPoint: addTipEndPint,
        data: formData,
        parameters: {"Title": title, "description": description},
      );
      emit(AddTipSuccessState());
    } catch (onError) {
      debugPrint("add tip error : $onError");
      emit(AddTipFailureState());
    }
  }

  Future<void> editTip({required id, required title, required description, required imageFile}) async {
    emit(EditTipLoadingState());
    try {
      FormData formData = FormData.fromMap({
        if (imageFile != null)
          'Image': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
      });
      await tomatopiaServices.update(
        token: token,
        endPoint: editTipEndPint,
        data: formData,
        query: {
          "Title": title,
          "description": description,
          "id": id,
        },
      );
      emit(EditTipSuccessState());
    } catch (onError) {
      debugPrint("edit tip error : $onError");
      emit(EditTipFailureState());
    }
  }
}
