import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_states.dart';
import 'package:tomatopia/page_transitions/scale_transition.dart';

import '../custom_widget/custom_card.dart';
import 'about_disease.dart';


class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<AdminCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: Form(
              key: formKey,
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      cubit.getDiseaseByName(name: value);
                      cubit.searchedDisease.clear();
                    }
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                        cubit.clearSearchedDisease();
                      },
                      icon: const Icon(
                        Icons.clear,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: state is GetDiseaseByNameLoadingState,
            builder: (context) => Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.green,
                size: 50,
              ),
            ),
            fallback: (context) => ConditionalBuilder(
              condition: state is GetAllDiseaseInitialState ||
                  cubit.searchedDisease.isEmpty,
              builder: (context) => Center(
                child: Image.asset('assets/search.jpg'),
              ),
              fallback: (context) => ListView.builder(
                itemCount: cubit.searchedDisease.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        ScaleTransition1(
                          DiseaseDetails(index: index),
                        ),
                      );
                    },
                    child: customCard(
                      image: cubit.searchedDisease[index].image!,
                      index: index,
                      context: context,
                      mainTitle: cubit.searchedDisease[index].name!,
                      subtitle: cubit.searchedDisease[index].category!.name!,
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
