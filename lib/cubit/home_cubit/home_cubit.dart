import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:tomatopia/api_models/add_react_model.dart';
import 'package:tomatopia/api_models/get_commetn_model.dart';
import 'package:tomatopia/api_models/tips_model.dart';
import 'package:tomatopia/cubit/home_cubit/home_states.dart';

import '../../api_models/get_all_posts_model.dart';
import '../../api_models/post_reaction.dart';
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
  List<PostReaction> postReactions = [];

  // Add a method to initialize the reactions list
  void initializeReactions() {
    postReactions = allPosts.map((post) => PostReaction(
      postId: post.id,
      isLike: post.isLike,
      isDislike: post.isDisLike,
    )).toList();
  }

  getAllPost() async {
    emit(GetAllPostsLoadingState());
    try {
      var value = await tomatopiaServices.getData(endPoint: getPosts, token: token,query: {"userId" : userId});
      data = value.data;
      allPosts.clear();
      // save reversed data in list
      for (int i = 0; i < data.length; i++) {
        allPosts.insert(0, GetPostsModel.fromJson(data[i]));
      }
      initializeReactions();
      emit(GetAllPostsSuccessState());
    } catch (onError) {
      debugPrint("get all posts error : $onError");
      emit(GetAllPostsFailureState());
    }
  }

  onSelectedItem({required value}) {
    currentIndex = value;
    emit(OnSelectedItemState());
  }

  AddReactModel? reactModel;

  addReactToPost({
    required int id,
    required bool like,
    required bool dislike,
  }) async {
    emit(AddReactPostsLoadingState());
    try {
      var value = await tomatopiaServices.postData(
        endPoint: addPostReact,
        data: {"objectId": id, "like": like, "dislike": dislike},
        token: token,
      );
      reactModel = AddReactModel.fromJson(value.data);

      // Find the post in allPosts and update its likes and dislikes
      var post = allPosts.firstWhere((element) => element.id == id);
      post.likes = reactModel!.likes;
      post.disLikes = reactModel!.disLikes;

      // Update the reactions list
      var reaction = postReactions.firstWhere((reaction) => reaction.postId == id);
      reaction.isLike = reactModel!.isLike;
      reaction.isDislike = reactModel!.isDislike;


      // Emit the updated state
      emit(AddReactPostsSuccessState());
    } catch (onError) {
      debugPrint("add react error : $onError");
      emit(AddReactPostsFailureState());
    }
  }

  Comment? commentModel;

  List<dynamic> commentData = [];
  List<Comment> commentPostList = [];

  getPostComments({required id}) async {
    emit(GetAllPostCommentsLoadingState());
    try {
      var value = await tomatopiaServices.getData(endPoint: getPostComment, query: {'postId': id});
      commentData = value.data;
      commentPostList.clear();
      for (int i = 0; i < commentData.length; i++) {
        commentPostList.add(Comment.fromJson(commentData[i]));
      }
      emit(GetAllPostCommentsSuccessState());
    } catch (onError) {
      debugPrint("get comments error : $onError");
      emit(GetAllPostCommentsFailureState());
    }
  }

  AddReactCommentModel? commentReactModel;

  addReactToComment({required int id, required bool like, required bool dislike}) async {
    emit(AddReactCommentLoadingState());
    try {
      var value = await tomatopiaServices.postData(
        endPoint: addCommentReact,
        data: {"objectId": id, "like": like, "dislike": dislike},
        token: token,
      );
      commentReactModel = AddReactCommentModel.fromJson(value.data);

      for (var comment in commentPostList) {
        if (comment.id == id) {
          comment.likes = commentReactModel!.likes!;
          comment.disLikes = commentReactModel!.disLikes!;
          break;
        }
      }
      emit(AddReactCommentSuccessState());
    } catch (onError) {
      debugPrint("add react error : $onError");
      emit(AddReactCommentFailureState());
    }
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
          'Image': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
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

  TipsModel? tipsModel;
  List<dynamic> tipsMap = [];
  List<TipsModel> allTips = [];

  getAllTips() async {
    emit(GetAllTipsLoadingState());
    try {
      var value = await tomatopiaServices.getData(endPoint: getTips, token: token);
      tipsMap = value.data;
      allTips.clear();
      for (int i = 0; i < tipsMap.length; i++) {
        allTips.add(TipsModel.fromJson(tipsMap[i]));
      }
      emit(GetAllTipsSuccessState());
    } catch (onError) {
      debugPrint('get tips error : $onError');
      emit(GetAllTipsFailureState());
    }
  }

  deletePost({required int id}) async {
    emit(DeletePostLoadingState());
    try {
      var value = await tomatopiaServices.deleteRequest(token: token, endpoint: deletePostEndpoint, query: {'id': id});
      emit(DeletePostSuccessState());
    } catch (onError) {
      debugPrint("delete post error : $onError");
      emit(DeletePostFailureState());
    }
  }

  deleteComment({required int id}) async {
    emit(DeleteCommentLoadingState());
    try {
      var value = await tomatopiaServices.deleteRequest(token: token, endpoint: deleteCommentEndpoint, query: {'id': id});
      emit(DeleteCommentSuccessState());
    } catch (onError) {
      debugPrint("delete comment error : $onError");
      emit(DeleteCommentFailureState());
    }
  }

  editPost({required String content, File? imageFile, required id}) async {
    emit(EditPostLoadingState());
    try {
      FormData formData = FormData.fromMap({
        'content': content,
        if (imageFile != null)
          'Image': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
      });

      var response = await tomatopiaServices.update(
        endPoint: editPostEndpoint,
        data: formData,
        query: {"id": id},
        token: token,
      );

      debugPrint(response.data.toString());
      emit(EditPostSuccessState());
    } catch (error) {
      debugPrint("edit post error : $error");
      emit(EditPostFailureState());
    }
  }

  removePostImage({required id}) async {
    emit(DeleteImageLoadingState());
    try {
      var value = await tomatopiaServices.deleteRequest(token: token, endpoint: deletePostImage, query: {'postId': id});
      debugPrint(value.data.toString());
      emit(DeleteImageSuccessState());
    } catch (onError) {
      debugPrint("delete image error : $onError");
      emit(DeleteImageFailureState());
    }
  }

  editComment({required String content, File? imageFile, required id}) async {
    emit(EditCommentLoadingState());
    try {
      FormData formData = FormData.fromMap({
        'content': content,
        if (imageFile != null)
          'Image': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
      });

      var response = await tomatopiaServices.update(
        endPoint: editCommentEndPoint,
        data: formData,
        query: {"id": id},
        token: token,
      );

      debugPrint(response.data.toString());
      emit(EditCommentSuccessState());
    } catch (error) {
      debugPrint("edit comment error : $error");
      emit(EditCommentFailureState());
    }
  }

  removeCommentImage({required id}) async {
    emit(DeleteCommentImageLoadingState());
    try {
      var value = await tomatopiaServices.deleteRequest(token: token, endpoint: deleteCommentImage, query: {'commentId': id});
      emit(DeleteCommentImageSuccessState());
    } catch (onError) {
      debugPrint("delete image error : $onError");
      emit(DeleteCommentImageFailureState());
    }
  }

  addCommentToPost({File? imageFile, required postId, required content}) async {
    emit(AddCommentLoadingState());
    try {
      FormData formData = FormData.fromMap({
        'content': content,
        'postId': postId,
        if (imageFile != null)
          'Image': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
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

  addReview({required review}) async {
    emit(AddReviewLoadingState());
    try {
      var response = await tomatopiaServices.postData(
        endPoint: addRevEndPoint,
        data: {
          "reviews" : review,
        },
        token: token,
      );

      debugPrint(response.data.toString());
      emit(AddReviewSuccessState());
    } catch (error) {
      debugPrint("add review error : $error");
      emit(AddReviewFailureState());
    }
  }
}
