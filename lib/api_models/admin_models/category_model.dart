class CategoryModel {
  final int id;
  final String name;
  final String createdDate;

  CategoryModel({
    required this.id,
    required this.name,
    required this.createdDate,
  });

  // Factory constructor to create an instance from a JSON map
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      createdDate: json['createdDate'],
    );
  }

}
