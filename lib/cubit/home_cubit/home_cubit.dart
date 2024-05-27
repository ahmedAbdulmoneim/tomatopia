import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:tomatopia/api_models/add_react_model.dart';
import 'package:tomatopia/api_models/tips_model.dart';
import 'package:tomatopia/cubit/home_cubit/home_states.dart';
import 'package:tomatopia/screens/search_screen.dart';

import '../../admin/tips.dart';
import '../../api_models/get_all_posts_model.dart';
import '../../api_services/tomatopia_services.dart';
import '../../constant/endpints.dart';
import '../../constant/variables.dart';
import '../../screens/alerts_screen.dart';
import '../../screens/community.dart';
import '../../screens/home_screen.dart';

class HomeCubit extends Cubit<HomePageStates> {
  HomeCubit(this.tomatopiaServices) : super(HomeInitialState());

  int currentIndex = 0;
  int? likes;

  int? disLikes;

  List<Widget> screens = [
    const HomeScreen(),
    const Community(),
    const Alerts(),

  ];

  TomatopiaServices tomatopiaServices;

  List<dynamic> data = [];
  List<GetPostsModel> allPosts = [];

  getAllPost() {
    emit(GetAllPostsSuccessState());
    tomatopiaServices.getData(endPoint: getPosts, token: token).then((value) {
      data = value.data;
      allPosts.clear();
      // save reversed data in list
      for (int i = 0; i < data.length; i++) {
        allPosts.insert(0, GetPostsModel.fromJson(data[i]));
      }
      debugPrint('${allPosts[10].comments[0].content}');
      emit(GetAllPostsSuccessState());
    }).catchError((onError) {
      debugPrint("get all posts error : $onError");
      emit(GetAllPostsFailureState());
    });
  }

  onSelectedItem({required value}) {
    currentIndex = value;
    emit(OnSelectedItemState());
  }

  AddReactModel? reactModel;

  addReactToPost(
      {required int id, required bool like, required bool dislike}) {
    emit(AddReactPostsLoadingState());
    tomatopiaServices
        .postData(
      endPoint: addPostReact,
      data: {"objectId": id, "like": like, "dislike": dislike},
      token: token,
    )
        .then((value) {
      reactModel = AddReactModel.fromJson(value.data);
      emit(AddReactPostsSuccessState());
    }).catchError((onError) {
      debugPrint("add react error : $onError");
      emit(AddReactPostsFailureState());
    });
  }


  AddReactCommentModel? commentReactModel;
  addReactToComment(
      {required int id, required bool like, required bool dislike}) {
    emit(AddReactCommentLoadingState());
    tomatopiaServices
        .postData(
      endPoint: addCommentReact,
      data: {"objectId": id, "like": like, "dislike": dislike},
      token: token,
    )
        .then((value) {
          print(value.data);
          commentReactModel = AddReactCommentModel.fromJson(value.data);
      emit(AddReactCommentSuccessState());
    }).catchError((onError) {
      debugPrint("add react error : $onError");
      emit(AddReactCommentFailureState());
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
      emit(LoadImagePost());
    } else {
      debugPrint("didn't select an image ");
    }
  }

  addPost({required String content, File? imageFile}) async {
    emit(AddPostLoadingState());

    try {
      FormData formData = FormData.fromMap({
        'content': content,
        if (imageFile != null)
          'Image': await MultipartFile.fromFile(imageFile.path,
              filename: 'image.jpg'),
      });

      var response = await tomatopiaServices.postData(
        endPoint: addNewPost,
        data: formData,
        token: token,
      );

      debugPrint(response.data.toString());
      getAllPost();
      emit(AddPostSuccessState());
    } catch (error) {
      debugPrint("add new post error : $error");
      emit(AddPostFailureState());
    }
  }

  clearPostImage() {
    imageFile = null;
    emit(ClearPostImage());
  }

  TipsModel? tipsModel ;
  List<dynamic> tipsMap = [];
  List<TipsModel> allTips = [];

  getAllTips(){
    emit(GetAllTipsLoadingState());
    tomatopiaServices.getData(endPoint: getTips,token: token).then((value) {
      tipsMap = value.data;
      allTips.clear();
      for(int i = 0; i< tipsMap.length;i++){
        allTips.add(TipsModel.fromJson(tipsMap[i]));
      }
      print(allTips[0].title);
      emit(GetAllTipsSuccessState());
    }).catchError((onError){
      debugPrint('ger tips error : $onError');
      emit(GetAllTipsFailureState());
    });
  }

  deletePost({required int id }){
    emit(DeletePostLoadingState());
    tomatopiaServices.deleteRequest(token: token, endpoint: deletePostEndpoint,query: {'id' : id}).then((value) {
      emit(DeletePostSuccessState());
    }).catchError((onError){
      debugPrint("delete post error : $onError");
      emit(DeletePostFailureState());
    });
  }

  deleteComment({required int id }){
    emit(DeleteCommentLoadingState());
    tomatopiaServices.deleteRequest(token: token, endpoint: deleteCommentEndpoint,query: {'id' : id}).then((value) {
      emit(DeleteCommentSuccessState());
    }).catchError((onError){
      debugPrint("delete post error : $onError");
      emit(DeleteCommentFailureState());
    });
  }

  editPost({required String content, File? imageFile,required id})async {
    emit(EditPostLoadingState());

    try {
      FormData formData = FormData.fromMap({
        'content': content,
        if (imageFile != null)
          'Image': await MultipartFile.fromFile(imageFile.path,
              filename: 'image.jpg'),
      });

      var response = await tomatopiaServices.update(
        endPoint: editPostEndpoint,
        data: formData,
        query: { "id" : id },
        token: token,
      );

      debugPrint(response.data.toString());
      emit(EditPostSuccessState());
    } catch (error) {
      debugPrint("edit post error : $error");
      emit(EditPostFailureState());
    }
  }
  removePostImage({required id}){
    emit(DeleteImageLoadingState());
    tomatopiaServices.deleteRequest(token: token, endpoint: deletePostImage,query: {'postId': id }).then((value) {
      debugPrint(value.data.toString());
      emit(DeleteImageSuccessState());
    }).catchError((onError){
      debugPrint("delete image error : $onError");
      emit(DeleteImageFailureState());
    });
  }

  addCommentToPost({File?imageFile,required postId,required content})async{
    emit(AddCommentLoadingState());
    try {
      FormData formData = FormData.fromMap({
        'content' :content,
        'postId' : postId,
        if (imageFile != null)
          'Image': await MultipartFile.fromFile(imageFile.path,
            filename: 'image.jpg'),
      });

      var response = await tomatopiaServices.postData(
        endPoint: addComment,
        data: formData,
        token: token,
      );

      debugPrint(response.data.toString());
      getAllPost();
      emit(AddCommentSuccessState());
    } catch (error) {
      debugPrint("add new Comment error : $error");
      emit(AddCommentFailureState());
    }

  }
}
