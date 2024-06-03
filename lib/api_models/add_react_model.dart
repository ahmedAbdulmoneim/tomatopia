class AddReactModel {
  final int id;

  final int likes;

  final int disLikes;

  AddReactModel({
    required this.id,
    required this.likes,
    required this.disLikes,
  });

  factory AddReactModel.fromJson(Map<String, dynamic> json) {
    return AddReactModel(
        id: json['postId'], likes: json['likes'], disLikes: json['dislikes']);
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
