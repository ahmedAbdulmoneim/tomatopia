class TreatmentModel {
  final int id;
  final String name;
  final String description;


  TreatmentModel({
    required this.id,
    required this.name,
    required this.description,

  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) {
    return TreatmentModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],

    );
  }


}

