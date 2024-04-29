class DiseaseModel {
  int? id;
  String? name;
  String? reasons;
  String? info;
  String? symptoms;
  Category? category;
  List<Treatments>? treatments;
  String? image;
  int? categoryId;

  DiseaseModel(
      {this.id,
        this.name,
        this.reasons,
        this.info,
        this.symptoms,
        this.category,
        this.treatments,
        this.image,
        this.categoryId});

  DiseaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    reasons = json['reasons'];
    info = json['info'];
    symptoms = json['symptoms'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['treatments'] != null) {
      treatments = <Treatments>[];
      json['treatments'].forEach((v) {
        treatments!.add(new Treatments.fromJson(v));
      });
    }
    image = json['image'];
    categoryId = json['categoryId'];
  }


}

class Category {
  int? id;
  String? name;
  DateTime? createdDate;

  Category({this.id, this.name, this.createdDate});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdDate = json['createdDate'];
  }


}

class Treatments {
  int? id;
  String? name;
  String? description;

  Treatments({this.id, this.name, this.description});

  Treatments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }


}
