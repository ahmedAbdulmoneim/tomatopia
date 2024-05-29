import 'dart:convert';
import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/admin_states.dart';
import 'package:tomatopia/page_transitions/scale_transition.dart';
import 'package:tomatopia/screens/disease_treatments.dart';


import 'full_screen_image.dart';

class DiseaseDetails extends StatelessWidget {
  const DiseaseDetails({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<AdminCubit>(context);
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: const Text('Diagnosis'),
            actions: [
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      SizeTransition1(
                        Treatments(
                          searchedDisease: cubit.searchedDisease,
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Treatments',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Positioned(
                top: 5,
                left: 5,
                right: 5,
                height: MediaQuery.of(context).size.height / 3,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        ScaleTransition1(FullScreenImage(
                            imageUrl: cubit.searchedDisease[index].image!)));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      base64Decode(cubit.searchedDisease[index].image!),
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.cover,
                      //height: MediaQuery.sizeOf(context).height / 3.2,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height / 4,
                left: 10,
                right: 10,
                bottom: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    children: [
                      Text(
                        cubit.searchedDisease[index].name!,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        cubit.searchedDisease[index].category!.name!,
                        style: const TextStyle(color: Colors.green),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Accordion(
                        contentBorderColor: Colors.black,
                        children: [
                          AccordionSection(
                            isOpen: true,
                            contentVerticalPadding: 20,
                            rightIcon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.black,
                            ),
                            headerPadding: const EdgeInsets.all(10),
                            headerBackgroundColor: Colors.greenAccent,
                            contentBackgroundColor:
                                Colors.greenAccent.withOpacity(.5),
                            leftIcon: const Icon(
                              Icons.info_outline,
                              color: Colors.black,
                            ),
                            header: const Text(
                              'Information',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text(
                              cubit.searchedDisease[index].info!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Text(
                                'Reasons',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                cubit.searchedDisease[index].reasons!,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'SYMPTOMS',
                        style: TextStyle(
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, -0.20),
                                color: Colors.blue,
                                blurRadius: 1,
                              ),
                            ],
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        cubit.searchedDisease[index].symptoms!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
