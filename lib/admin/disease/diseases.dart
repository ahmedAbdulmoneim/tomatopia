import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tomatopia/admin/disease/about_disease.dart';
import 'package:tomatopia/cubit/admin_cubit/disease/disease_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/disease/disease_states.dart';

class AllDiseases extends StatelessWidget {
  const AllDiseases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiseaseCubit, DiseaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<DiseaseCubit>(context);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: const Text('All Diseases'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: state is GetAllDiseaseLoadingState ||
                  state is GetAllDiseaseFailuerState
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blue, size: 50))
              : ListView.builder(
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
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiseaseDetails(
                                    index: index,
                                  )),
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
                                  base64Decode(cubit.allDisease[index].image!),
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
                                      cubit.allDisease[index].name!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      cubit.allDisease[index].category!.name!,
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
                  itemCount: cubit.allDisease.length,
                ),
        );
      },
    );
  }
}
