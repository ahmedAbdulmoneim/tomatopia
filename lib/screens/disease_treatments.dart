import 'package:flutter/material.dart';
import 'package:tomatopia/api_models/admin_models/disease_model.dart';
import 'package:tomatopia/custom_widget/extensions.dart';

class Treatments extends StatelessWidget {
  const Treatments({super.key, required this.index, required this.searchedDisease});

  final List<DiseaseModel> searchedDisease;
  final int index;

  @override
  Widget build(BuildContext context) {
    final disease = searchedDisease[index];
    final treatments = disease.treatments?.map((t) => t.description!).toList() ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(context.treatments),
      ),
      body: PlantDiseaseTreatmentWidget(
        diseaseName: disease.name!,
        treatments: treatments,
      ),
    );
  }
}

class PlantDiseaseTreatmentWidget extends StatelessWidget {
  final String diseaseName;
  final List<String> treatments;

  const PlantDiseaseTreatmentWidget({
    super.key,
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
            '${context.treatmentFor} $diseaseName',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            context.recommendedTreatments,
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: treatments.map((treatment) {
              return Padding(
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
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

