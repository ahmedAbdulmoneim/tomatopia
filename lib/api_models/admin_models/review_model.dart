class ReviewModel {
  String? reviews;
  String? type;

  ReviewModel({this.reviews, this.type});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    reviews = json['reviews'];
    type = json['type'];
  }
}
