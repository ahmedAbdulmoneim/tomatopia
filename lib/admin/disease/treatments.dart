import 'package:flutter/material.dart';
import 'package:tomatopia/api_models/admin_models/disease_model.dart';

class Treatments extends StatelessWidget {
  Treatments({super.key,required this.index,required this.allDiseases});
  List<DiseaseModel> allDiseases ;
  int index ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Treatments',
        ),
      ),
      body: PlantDiseaseTreatmentWidget(
        diseaseName: allDiseases[index].treatments![0].name!,
        treatments: [
          allDiseases[index].treatments![0].description!,
        ]
      ),
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
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Treatment for $diseaseName',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Here are some recommended treatments:',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: treatments.map((treatment) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      treatment,
                      style: TextStyle(fontSize: 16.0),
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
