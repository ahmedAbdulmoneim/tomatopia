

class GetPostsModel {
  final int id;
  final String content;
  final String image;
  final String userImage;
  final String creationDate;
  final int likes;
  final int disLikes;
  final List<dynamic> comments;
  final String userId;

  GetPostsModel({
    required this.id,
    required this.content,
    required this.image,
    required this.userImage,
    required this.creationDate,
    required this.likes,
    required this.disLikes,
    required this.comments,
    required this.userId,
  });

  factory GetPostsModel.fromJson(Map<String, dynamic> json) {
    return GetPostsModel(
      id: json['id'],
      content: json['content'],
      image: json['image'],
      userImage: json['userImage'],
      creationDate: json['creationDate'],
      likes: json['likes'],
      disLikes: json['disLikes'],
      comments: json['comments'],
      userId: json['userId'],
    );
  }
}




