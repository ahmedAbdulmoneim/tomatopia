import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/admin/disease/treatments.dart';
import 'package:tomatopia/cubit/admin_cubit/disease/disease_cubit.dart';
import 'package:tomatopia/cubit/admin_cubit/disease/disease_states.dart';

class DiseaseDetails extends StatelessWidget {
  const DiseaseDetails({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiseaseCubit, DiseaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<DiseaseCubit>(context);
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Treatments(allDiseases: cubit.allDisease,index: index,),),);

                  },
                  child: const Text(
                    'Treatments',
                     style: TextStyle(
                       color: Colors.blue
                     ),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 15, right: 15, bottom: 10),
            child: ListView(
              children: [
                Text(
                  cubit.allDisease[index].name!,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  cubit.allDisease[index].category!.name!,
                  style: const TextStyle(color: Colors.green),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    base64Decode(cubit.allDisease[index].image!),
                    width: MediaQuery.sizeOf(context).width,
                    fit: BoxFit.cover,
                    height: MediaQuery.sizeOf(context).height / 3.2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: const Color(0xffcce2ff).withOpacity(.8),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline,
                            color: Color(0xFF0F3164)),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            cubit.allDisease[index].info!,
                            style: const TextStyle(color: Color(0xFF0F3164)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                          cubit.allDisease[index].reasons!,
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
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  cubit.allDisease[index].symptoms!,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
