import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/cubit/home_cubit/home_cubit.dart';
import 'package:tomatopia/cubit/home_cubit/home_states.dart';
import 'package:tomatopia/custom_widget/community_card.dart';
import 'package:tomatopia/custom_widget/custom_row.dart';
import 'package:tomatopia/page_transitions/scale_transition.dart';
import 'package:tomatopia/screens/add_post_screen.dart';
import '../custom_widget/search_box.dart';

class Community extends StatelessWidget {
  const Community({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<HomeCubit, HomePageStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = BlocProvider.of<HomeCubit>(context);
          final ScrollController scrollController = ScrollController();
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              elevation: .6,
              backgroundColor: Colors.green[300],
              label: customRow(width: 5, icon: Icons.add, text: 'ask community'),
              onPressed: (){
                Navigator.push(context, SizeTransition1(AddPost()));
              },
            ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  children: [
                    searchBox(),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ConditionalBuilder(
                        condition: state is GetAllPostsLoadingState,
                        builder: (context) =>
                            Center(
                              child: LoadingAnimationWidget.waveDots(
                                  color: Colors.green, size: 50),
                            ),
                        fallback: (context) {
                          // After the data is loaded, scroll to the bottom
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if(state is GetAllPostsSuccessState) {
                              scrollController.jumpTo(
                                scrollController.position.maxScrollExtent,);
                            }
                          });

                          return RefreshIndicator(
                            color: Colors.green,
                            onRefresh: () {
                              // Trigger data fetch
                              cubit.getAllPost();
                              return Future(() => null);
                            },
                            child: ListView.builder(
                              reverse: true,
                              controller: scrollController,
                              itemBuilder: (context, index) => communityCard(
                                index: index,
                                postImage: cubit.allPosts[index].image != null ?'http://graduationprojec.runasp.net//${cubit.allPosts[index].image}' : '',
                                userImageInPost: 'http://graduationprojec.runasp.net//${cubit.allPosts[index].userImage}',
                                content: cubit.allPosts[index].content,
                                context: context,
                                dislikes: cubit.allPosts[index].disLikes,
                                userNameInPost: cubit.allPosts[index].userName,
                                creationDate: cubit.allPosts[index].creationDate,
                                likes: cubit.allPosts[index].likes,
                                id: cubit.allPosts[index].id
                              ),
                              itemCount: cubit.allPosts.length,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          );
        },
      ),
    );
  }
}