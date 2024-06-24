
class GetPostsModel {
  final int id;
  final String content;
  final String? image;
  final String? userImage;
  final String creationDate;
  int likes;
  int disLikes;
  final int comments;
  final String userId;
  final String userName;
  bool isDisLike;
  bool isLike;

  GetPostsModel({
    required this.id,
    required this.content,
    this.image,
    required this.creationDate,
    required this.likes,
    required this.disLikes,
    required this.comments,
    required this.userName,
    this.userImage,
    required this.userId,
    required this.isDisLike,
    required this.isLike
  });

  factory GetPostsModel.fromJson(Map<String, dynamic> json) {
    return GetPostsModel(
      id: json['id'],
      content: json['content'],
      image: json['image'],
      creationDate: json['creationDate'],
      likes: json['likes'],
      disLikes: json['disLikes'],
      comments: json['comments'],
      userName: json['userName'],
      userImage: json['userImage'],
      userId: json['userId'],
      isLike: json['isLike'],
      isDisLike: json['isDisLike'],
    );
  }


}

// Example usage:
