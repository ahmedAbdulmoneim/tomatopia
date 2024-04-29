import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatopia/api_models/admin_models/disease_model.dart';
import 'package:tomatopia/api_services/tomatopia_services.dart';
import 'package:tomatopia/constant/endpints.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/admin_cubit/disease/disease_states.dart';

class DiseaseCubit extends Cubit<DiseaseStates>{
  DiseaseCubit(this.tomatopiaServices): super(GetAllDiseaseInitialState());

  TomatopiaServices tomatopiaServices ;
  DiseaseModel? diseaseModel ;
  List<dynamic> data = [];
  List<DiseaseModel> allDisease = [];
  getAllDisease(){
    emit(GetAllDiseaseLoadingState());
    tomatopiaServices.getData(endPoint: getAllDiseaseEndpoint,token: token).then((value){
      data = value.data ;
      for (int i = 0; i < data.length; i++) {
        allDisease.add(DiseaseModel.fromJson(data[i]));
      }
      print(allDisease[0].name);
      emit(GetAllDiseaseSuccessState());
    }).catchError((onError){
      print("get disease error her : $onError");
      emit(GetAllDiseaseFailuerState());
    });
  }

  addDisease({
    required String name,
    required String info,
    required String reasons,
    required int categoryId,
    required String symptoms,
    required FormData data,
    required int treatments,
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
      print(value.data);
      emit(AddDiseaseSuccessState());
    }).catchError((onError) {
      print('add disease error : $onError');
      emit(AddDiseaseFailuerState());
    });
  }


}