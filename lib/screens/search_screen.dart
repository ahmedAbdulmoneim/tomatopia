// Import the package
import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/api_models/admin_models/disease_model.dart';
import 'package:tomatopia/page_transitions/scale_transition.dart';

import 'about_disease.dart';
import '../cubit/admin_cubit/disease/disease_cubit.dart';
import '../cubit/admin_cubit/disease/disease_states.dart';


class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<DiseaseCubit, DiseaseStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<DiseaseCubit>(context);
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
                builder: (context) =>  Center(
                  child: Image.asset(
                    'assets/search.jpg'
                  ),
                ),
                fallback: (context) => ListView.builder(
                  itemCount: cubit.searchedDisease.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 6,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 8),
                    child: InkWell(
                      onLongPress: (){},
                      onTap: () {
                        Navigator.push(
                          context,ScaleTransition1(DiseaseDetails(
                          index: index,
                        ))
                        );
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  base64Decode(cubit.searchedDisease[index].image!),
                                  fit: BoxFit.fill,
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.searchedDisease[index].name!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      cubit.searchedDisease[index].category!.name!,
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
