// class ReviewModel {
//   String? reviews;
//   String? type;
//
//   ReviewModel({this.reviews, this.type});
//
//   ReviewModel.fromJson(Map<String, dynamic> json) {
//     reviews = json['reviews'];
//     type = json['type'];
//   }
// }


class ReviewModel {
  String? positive;
  String? negative;
  List<Reviews>? reviews;

  ReviewModel({this.positive, this.negative, this.reviews});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    positive = json['positive'];
    negative = json['negative'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }


}

class Reviews {
  String? reviews;
  String? type;

  Reviews({this.reviews, this.type});

  Reviews.fromJson(Map<String, dynamic> json) {
    reviews = json['reviews'];
    type = json['type'];
  }

}
