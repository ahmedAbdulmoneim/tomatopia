class TipsModel {
  int? id;
  String? title;
  String? image;
  String? description;
  String? createDate;

  TipsModel(
      {this.id, this.title, this.image, this.description, this.createDate});

  TipsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    createDate = json['createDate'];
  }
}
