import 'package:flutter/material.dart';
import 'package:tomatopia/api_models/admin_models/disease_model.dart';

class Treatments extends StatelessWidget {
  const Treatments({super.key, required this.index, required this.searchedDisease});

  final List<DiseaseModel> searchedDisease;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Treatments',
        ),
      ),
      body: PlantDiseaseTreatmentWidget(
          diseaseName: searchedDisease[index].treatments![1].name!,
          treatments: [
            searchedDisease[index].treatments![1].description!,
          ]),
    );
  }
}

class PlantDiseaseTreatmentWidget extends StatelessWidget {
  final String diseaseName;
  final List<String> treatments;

  const PlantDiseaseTreatmentWidget({
    required this.diseaseName,
    required this.treatments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Treatment for $diseaseName',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Here are some recommended treatments:',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: treatments
                .map((treatment) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              treatment,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
