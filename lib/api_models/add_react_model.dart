class AddReactModel {
  final int id;

  final int likes;

  final int disLikes;
  bool isDislike;
  bool isLike;

  AddReactModel({
    required this.id,
    required this.likes,
    required this.disLikes,
    required this.isLike,
    required this.isDislike,
  });

  factory AddReactModel.fromJson(Map<String, dynamic> json) {
    return AddReactModel(
        id: json['postId'], likes: json['likes'], disLikes: json['dislikes'],isDislike: json["isDislike"],isLike: json["islike"]);
  }
}

class AddReactCommentModel {
  final int? id;
  final int? likes;
  final int? disLikes;

  AddReactCommentModel({
    required this.id,
    required this.likes,
    required this.disLikes,
  });

  factory AddReactCommentModel.fromJson(Map<String, dynamic> json) {
    return AddReactCommentModel(
      id: json['id'],
      likes: json['likes'],
      disLikes: json['dislikes'],
    );
  }
}

// Example usage
