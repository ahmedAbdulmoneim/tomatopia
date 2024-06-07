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

 int numberOfPages = 1 ;
  showAllUsers({
    required dynamic pageSize,
    required dynamic pageNumber,
  }) {
    emit(GetAllUsersLoadingState());
    tomatopiaServices.getData(endPoint: getAllUsers, token: token, query: {
      'pageSize': pageSize,
      'pageNumber': pageNumber,
    }).then((value) {
      userModel = AllUserModel.fromJson(value.data);
      numberOfPages = userModel!.usersNumber!;
      emit(GetAllUsersSuccessState());
    }).catchError((onError) {
      debugPrint('get all users error : $onError');
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
      debugPrint('delete user error : $onError');
      emit(DeleteUsersFailuerState());
    });
  }

  int currentPage = 0 ;
  onPageChange(int index){
 currentPage = index;
 emit(OnPageChange());
  }

  // category
  CategoryModel?categoryModel;

  List<dynamic> categories = [];
  List<CategoryModel> categoryList = [];
  getAllCategories() {
    emit(GetAllCategoryLoadingState());
    tomatopiaServices.getData(endPoint: getAllCat, token: token).then((value) {
      categories = value.data;
      categoryList.clear();
      for (int i = 0; i < categories.length; i++) {
        categoryList.add(CategoryModel.fromJson(categories[i]));
      }
      emit(GetAllCategorySuccessState());
    }).catchError((onError) {
      emit(GetAllCategoryFailureState());
    });
  }

  DeleteModel? deleteCategoryModel;

  deleteCategory({required int id}) {
    emit(DeleteCategoryLoadingState());
    tomatopiaServices.deleteRequest(
        token: token, endpoint: deleteCat, query: {'id': '$id'}).then((value) {
      deleteCategoryModel = DeleteModel.fromJson(value.data);
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

  DeleteModel? addModel;

  addCategory({required String newCategory})
  {
    emit(AddCategoryLoadingState());
    tomatopiaServices
        .postData(endPoint: addCat, data: {"name": newCategory}, token: token)
        .then((value) {
      addModel = DeleteModel.fromJson(value.data);
      emit(AddCategorySuccessState());
    }).catchError((onError) {
      debugPrint('add category error : $onError');
      emit(AddCategoryFailureState());
    });
  }

  // diseases

  DiseaseModel? diseaseModel ;
  List<dynamic> data = [];
  List<DiseaseModel> allDisease = [];
  getAllDisease(){
    emit(GetAllDiseaseLoadingState());
    tomatopiaServices.getData(endPoint: getAllDiseaseEndpoint,token: token).then((value){
      data = value.data ;
      debugPrint(data.toString());
      allDisease.clear();
      for (int i = 0; i < data.length; i++) {
        allDisease.add(DiseaseModel.fromJson(data[i]));
      }
      emit(GetAllDiseaseSuccessState());
    }).catchError((onError){
      debugPrint("get disease error her : $onError");
      emit(GetAllDiseaseFailureState());
    });
  }

  addDisease({
    required String name,
    required String info,
    required String reasons,
    required int categoryId,
    required String symptoms,
    required FormData data,
    required List<int> treatments,
  }) {
    emit(AddDiseaseLoadingState());
    tomatopiaServices.postData(
      endPoint: addDiseaseEndpoint,
      token: token,
      data: data ,
      parameters: {
        "Treatments": treatments,
        "CategoryId": categoryId,
        "symptoms": symptoms,
        "info": info,
        "name": name,
        "reasons": reasons,
      },
    ).then((value) {
      debugPrint(value.data);
      emit(AddDiseaseSuccessState());
    }).catchError((onError) {
      debugPrint('add disease error : $onError');
      emit(AddDiseaseFailureState());
    });
  }

  editDisease({
    required String name,
    required String info,
    required String reasons,
    required int categoryId,
    required int id,
    required String symptoms,
    File? imageFile,
    required List<int> treatments,
  }) async {
    emit(EditDiseaseLoadingState());
    FormData formData = FormData.fromMap({
      if (imageFile != null)
        'Image': await MultipartFile.fromFile(imageFile.path,
          filename: 'image.jpg'),
    });
    tomatopiaServices.update(
      endPoint: editDiseaseEndPoint,
      token: token,
      data: formData ,
      query: {
        "id" : id,
        "Treatments": treatments,
        "CategoryId": categoryId,
        "symptoms": symptoms,
        "info": info,
        "name": name,
        "reasons": reasons,
      },
    ).then((value) {
      debugPrint(value.data);
      emit(EditDiseaseSuccessState());
    }).catchError((onError) {
      debugPrint('edit disease error : $onError');
      emit(EditDiseaseFailureState());
    });
  }

  List<dynamic> searchData = [];
  List<DiseaseModel> searchedDisease = [];
  getDiseaseByName(
      {
        required String name ,
      }
      ){
    emit(GetDiseaseByNameLoadingState());
    tomatopiaServices.getData(endPoint: getDiseaseByNameEndpoint,token: token,query: {'name' : name}).then((value) {
      searchData = value.data ;
      for (int i = 0; i < searchData.length; i++) {
        searchedDisease.add(DiseaseModel.fromJson(searchData[i]));
      }
      debugPrint('treatments : ${value.data[0]['category']}');
      emit(GetDiseaseByNameSuccessState());
    }).catchError((onError){
      debugPrint('get disease by name error : $onError');
      emit(GetDiseaseByNameFailureState());
    });

  }

  clearSearchedDisease(){
    searchedDisease.clear();
    emit(ClearSearchedDisease());
  }

  deleteDiseases(
      {
        required int id ,
      }
      ){
    emit(DeleteDiseaseLoadingState());
    tomatopiaServices.deleteRequest(token: token, endpoint: deleteDisease,query: {
      'id' : id
    }).then((value) {
      debugPrint("${value.data}");
      allDisease.clear();
      emit(DeleteDiseaseSuccessState());
      emit(GetAllDiseaseSuccessState());
    }).catchError((onError){
      debugPrint("delete disease error : $onError");
      emit(DeleteDiseaseFailureState());
    });

  }

  // treatment

 List<dynamic> treatments = [];
  List<TreatmentModel> treatmentList = [];

  getAllTreatment(){
    emit(GetAlTreatmentLoadingState());
    tomatopiaServices.getData(endPoint: getAllTreatmentEndPoint,token: token).then((value) {
      treatments = value.data;
      treatmentList.clear();
      for (int i = 0; i < treatments.length; i++) {
        treatmentList.add(TreatmentModel.fromJson(treatments[i]));
      }
      emit(GetAllTreatmentSuccessState());
    }).catchError((onError){
      debugPrint('get treatment error : $onError');
      emit(GetAllTreatmentFailureState());
    });
  }

  deleteTreatment({required id}){
    emit(DeleteTreatmentLoadingState());
    tomatopiaServices.deleteRequest(token: token, endpoint: deleteTreatmentEndPoint,query: {"id" : id}).then((value){
      emit(DeleteTreatmentSuccessState());
    }).catchError((onError){
      debugPrint("delete treatment error : $onError");
      emit(DeleteTreatmentFailureState());
    });
  }

  addTreatment({required name,required description}){
    emit(AddTreatmentLoadingState());
    tomatopiaServices.postData(
        endPoint: addTreatmentEndPoint,
        data: {
          "name": name,
          "description" : description,
        },
        token: token,
    ).then((value){
      emit(AddTreatmentSuccessState());
    }).catchError((onError){
      debugPrint("add treatment error : $onError");
      emit(AddTreatmentFailureState());
    });

  }

  editTreatment({required id,required name,required description}){
    emit(EditTreatmentLoadingState());
    tomatopiaServices.update(
      endPoint: editTreatmentEndPoint,
      data: {
        "id" : id,
        "name": name,
        "description" : description,
      },
      token: token,
    ).then((value){
      emit(EditTreatmentSuccessState());
    }).catchError((onError){
      debugPrint("edit treatment error : $onError");
      emit(EditTreatmentFailureState());
    });

  }












  File? imageFile;
  FormData? formData;

  Future picImageFromGallery() async {
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
      debugPrint("didn't select an image ");
    }
  }

  clearImage() {
    imageFile = null;
    emit(ClearDiseaseImage());
  }

  int? selectedCategoryId;
  selectCategory(value){
    selectedCategoryId = value;
    emit(SelectCategoryId());
  }


  // tips

  List<dynamic> tipsMap = [];
  List<TipsModel> allTips = [];

  getAllTips(){
    emit(GetTipsLoadingState());
    tomatopiaServices.getData(endPoint: getTips,token: token).then((value) {
      tipsMap = value.data;
      allTips.clear();
      for(int i = 0; i< tipsMap.length;i++){
        allTips.add(TipsModel.fromJson(tipsMap[i]));
      }
      emit(GetTipsSuccessState());
    }).catchError((onError){
      debugPrint('ger tips error : $onError');
      emit(GetTipsFailureState());
    });
  }

  deleteTip({required id}){
    emit(DeleteTipLoadingState());
    tomatopiaServices.deleteRequest(token: token, endpoint: deleteTipEndPoint,query: {"id": id}).then((value){
      emit(DeleteTipSuccessState());
    }).catchError((onError){
      debugPrint("delete tip error : $onError");
    });
  }
  
  addTip({required title,required description,required imageFile}) async {
    emit(AddTipLoadingState());
    FormData formData = FormData.fromMap({
      if (imageFile != null)
        'Image': await MultipartFile.fromFile(imageFile.path,
          filename: 'image.jpg'),
    });
    tomatopiaServices.postData(token : token,endPoint: addTipEndPint, data: formData,parameters: {"Title" : title,"description": description}).then((value) {
      emit(AddTipSuccessState());
    }).catchError((onError){
      debugPrint("add tip error : $onError");
      emit(AddTipFailureState());
    });
  }

  editTip({required id,required title,required description,required imageFile}) async {
    emit(EditTipLoadingState());
    FormData formData = FormData.fromMap({
      if (imageFile != null)
        'Image': await MultipartFile.fromFile(imageFile.path,
            filename: 'image.jpg'),
    });
    tomatopiaServices.update(token : token,
        endPoint: editTipEndPint,
        data: formData,
        query:
        {
          "Title" : title,
          "description": description,
          "id" : id,
        }).then((value) {
      emit(EditTipSuccessState());
    }).catchError((onError){
      debugPrint("add tip error : $onError");
      emit(EditTipFailureState());
    });
  }
}
