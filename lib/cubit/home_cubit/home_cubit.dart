import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
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

class HomeCubit extends Cubit<HomePageStates>{
  HomeCubit(this.tomatopiaServices):super(HomeInitialState());

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    Search(),
    Community(),
    Alerts(),
    Tips()
  ];

  TomatopiaServices tomatopiaServices ;
  GetPostsModel? getPostsModel ;
  List<dynamic> data = [];
  List<GetPostsModel> allPosts = [];

  getAllPost(){
    emit(GetAllPostsSuccessState());
    tomatopiaServices.getData(endPoint: getPosts,token: token).then((value) {
      data = value.data ;
      allPosts.clear();
      for (int i = 0; i < data.length; i++) {
        allPosts.add(GetPostsModel.fromJson(data[i]));
      }
      debugPrint("${allPosts.length}");
      emit(GetAllPostsSuccessState());
    }).catchError((onError){
      debugPrint("get all posts error : $onError");
      emit(GetAllPostsFailureState());
    });
  }

  onSelectedItem({required value}){
    currentIndex = value ;
    emit(OnSelectedItemState());
  }

}